# -*- coding: utf-8 -*-
'''
apache directives
:maintainer:    "karim Hamza"


'''

from __future__ import absolute_import, unicode_literals

# Import python libs
import re
from copy import deepcopy


from salt.exceptions import CommandExecutionError
from salt.ext.six.moves import range


def _get_directive_values(directive, d_list):
    '''
    Returns list all values of directive
    '''
    values = [item.get(directive) for item in d_list if directive in item]

    return values


def get_directive_single_value(directive, d_list, default=None):
    '''
    Returns single value of directive

    default is returned if directive is absent from list
    '''
    values = _get_directive_values(directive, d_list)
    try:
        return values[0]
    except IndexError:
        if default is not None:
            return default

        error_msg = "invalid Pillar content - " \
                    + directive + " - is not defined"
        raise CommandExecutionError(error_msg)


def append_to_container_directives(directive, value, container):
    '''
    Append directive to directives list
    '''
    try:
        container['directives'].append({directive: value})
    except KeyError:
        container['directives'] = []
        container['directives'].append({directive: value})

    return container


def _manage_directive_into_containers(directive,
                                     value,
                                     container,
                                     container_name_target,
                                     item,
                                     enforce_value=False,
                                     add_directive=True):
    '''
    Enforce value for directive into specific container

    directive
        directive label (name)

    value
        value to enforce

    container
        container to parse

    container_name_target
        container name target into directive/value have to be enforced

    item
        name of the item target

    enforce_value : default=False
        True: enforce value if directive exists, otherwise add it if add_directive=True

    add_directive : default=True
        Only if enforce_value=False add directive if it is not present
    '''
    for n_container, l_containers in container.get('containers', {}).items():
        for idx, nested_container in enumerate(l_containers):
            if (n_container == container_name_target
                    and nested_container['item'] == item):
                if enforce_value:
                    container['containers'][n_container][idx] = \
                        enforce_directive_value(directive,
                                                {'value': value, 'add_if_absent': add_directive},
                                                n_container,
                                                nested_container)
                else:
                    container['containers'][n_container][idx] = \
                        append_to_container_directives(directive,
                                                       value,
                                                       nested_container)

            container['containers'][n_container][idx] = \
                    _manage_directive_into_containers(directive,
                                                     value,
                                                     nested_container,
                                                     container_name_target,
                                                     item,
                                                     enforce_value,
                                                     add_directive)

    return container


def set_vhost_logging_directives(container, servername, logdir):
    '''
    set value of CustomLog and LogFormat directives in vhost
    '''
    logformat = get_directive_single_value('LogFormat',
                                           container.get('directives', []),
                                           default='combined')

    enforce_directive_value(
        directive='CustomLog',
        enforced_directive_data=
            {'value': logdir + '/' + servername +'-access.log ' + logformat,
             'add_if_absent': True},
        container_name='VirtualHost',
        container_data=container)
    enforce_directive_value(
        directive='ErrorLog',
        enforced_directive_data=
            {'value': logdir + '/' + servername +'-error.log ',
             'add_if_absent': True},
        container_name='VirtualHost',
        container_data=container)

    return container


def _container_merge_multiple_directives(container):
    '''
    append directives_multiple list into directives
    '''
    try:
        container['directives'].extend(container.get('directives_multiple', []))
    except KeyError:
        container['directives'] = []
        container['directives'] = container.get('directives_multiple', [])

    container.pop('directives_multiple', None)

    for sub_container_name, sub_containers_list in container.get('containers', {}).items():
        for sub_idx, sub_container in enumerate(sub_containers_list):
            container['containers'][sub_container_name][sub_idx] = \
            _container_merge_multiple_directives(sub_container)

    return container


def merge_container_with_additional_data(container_to_update,
                                         container_to_import,
                                         add_directive=True,
                                         add_container=True):
    '''
    Merge containers usually to merge default values with pillar content

    container_to_update
        the default container into which put or modify values with pillar content

    container_to_import
        usually pillar content

    add_directive : default=True
        add directive if it is not present

    add_container : default=True
        add sub_container if it is absent in container_to_update
    '''
    merged_container = deepcopy(container_to_update)
    multiple_directives_to_append = []
    for mult_directive_item in container_to_update.get('directives_multiple', []):
        for mult_directive, imp_value in mult_directive_item.items():
            append_to_container_directives(mult_directive,
                                           imp_value,
                                           merged_container)
            if mult_directive not in multiple_directives_to_append:
                multiple_directives_to_append.append(mult_directive)
    merged_container.pop('directives_multiple', None)

    for p_directive_item in container_to_import.get('directives', []):
        for p_directive, p_value in p_directive_item.items():
            if p_directive in multiple_directives_to_append:
                append_to_container_directives(p_directive,
                                               p_value,
                                               merged_container)
            else:
                merged_container = enforce_directive_value(
                    p_directive,
                    {'value': p_value, 'add_if_absent': add_directive},
                    'virtual_name_container',
                    merged_container)
    # containers:
    sub_containers_to_update = merged_container.get('containers', {})
    sub_containers_to_import = container_to_import.get('containers', {})
    if sub_containers_to_update and sub_containers_to_import:
        # merge directives of sub containers
        for container_name, u_container_list in sub_containers_to_update.items():
            to_imp_containers = sub_containers_to_import.get(container_name, [])
            for container_idx, to_upd_container_data in enumerate(u_container_list):
                imp_items_containers = [container for container in to_imp_containers
                                        if container['item'] == to_upd_container_data['item']]
                for i_item_container in imp_items_containers:
                    merged_container['containers'][container_name][container_idx] = \
                        merge_container_with_additional_data(
                            merged_container['containers'][container_name][container_idx],
                            i_item_container,
                            add_directive)
            if add_container:
                # merge containers not present in default 'container_name' list
                d_container_items = set([container.get('item') for container
                                                                in u_container_list])
                p_container_items = set([container.get('item') for container
                                in to_imp_containers])
                items_diff = (p_container_items - d_container_items)
                for item in items_diff:
                    merged_container['containers'][container_name].extend(
                        [container for container in to_imp_containers if
                            container.get('item') == item])

        if add_container:
            # merge global containers not present in default
            k_containers_diff = (set(sub_containers_to_import.keys())
                                 - set(sub_containers_to_update.keys()))
            for k_container in k_containers_diff:
                merged_container['containers'][k_container] = {}
                merged_container['containers'][k_container] = sub_containers_to_import[k_container]

    elif not sub_containers_to_update \
            and sub_containers_to_import \
            and add_container:
        merged_container['containers'] = {}
        merged_container['containers'] = sub_containers_to_import
    elif not sub_containers_to_import:
        pass

    # move directives_multiple into directives and delete directives_multiple
    for container_name, containers_list in merged_container.get('containers', {}).items():
        for container_idx, container_data in enumerate(containers_list):
            merged_container['containers'][container_name][container_idx] = \
                _container_merge_multiple_directives(container_data)

    return merged_container


def enforce_security_directives_into_containers(container_to_secure,
                                                secured_containers,
                                                add_directive=True,
                                                add_container=True):
    '''
    Merge secured containers into pillar content

    container_to_secure
        usually pillar content

    secured_containers
        content of hadened values

    add_directive : default=True
        add directive if it is not present

    add_container : default=True
        add sub_container if it is absent in container_to_secure
    '''
    i_secured_containers = {}
    i_secured_containers['containers'] = secured_containers
    container_to_secure = merge_container_with_additional_data(
        container_to_secure,
        i_secured_containers,
        add_directive=add_directive,
        add_container=add_container)
    # search in (sub) nested containers and secure them
    for secure_container_name, l_s_containers in secured_containers.items():
        for s_container in l_s_containers:
            # search into container_to_secure
            secured_item = s_container.get('item')
            for s_directive in s_container.get('directives', []):
                for s_d_label, s_d_value in s_directive.items():
                    container_to_secure = _manage_directive_into_containers(
                        s_d_label,
                        s_d_value,
                        container_to_secure,
                        container_name_target=secure_container_name,
                        item=secured_item,
                        enforce_value=True,
                        add_directive=add_directive)

    return container_to_secure


def _substitute_value(text, enforced_value):
    '''
    conditional replace in 'text' with regex and condition

    text
        string to process

    enforced_value
        dict :
            match: regex to match
            value: value to enforce
            onlyif_pillar_is: condition on pillar content
            regex_group_position: number of group to replace in regex
    '''
    def my_match_function(m_object):

        return_value = ''.join([m_object.group(idx) for idx in range(1, position)
                                if m_object.group(idx) is not None])
        if condition == 'greater':
            return_value = return_value \
                           + str(min(int(m_object.group(position)), int(enforced_value['value']))) \
                           + ''.join([m_object.group(idx) for idx in range(position+1, m_object.lastindex+1) if m_object.group(idx) is not None])
        elif condition == 'lower':
            return_value = return_value \
                           + str(max(int(m_object.group(position)), int(enforced_value['value']))) \
                           + ''.join([m_object.group(idx) for idx in range(position+1, m_object.lastindex+1) if m_object.group(idx) is not None])

        elif condition == 'different' and m_object.group(position) != str(enforced_value['value']):
            return_value = return_value \
                           + enforced_value['value'] \
                           + ''.join([m_object.group(idx) for idx in range(position+1, m_object.lastindex+1) if m_object.group(idx) is not None])
        else:
            return_value = m_object.group(0)

        return return_value

    _pattern = re.compile(enforced_value.get('match', r'(\S+(\s+\S+)*)'), re.IGNORECASE)
    condition = enforced_value.get('onlyif_pillar_is', 'different')
    position = enforced_value.get('regex_group_position', 1)
    value = _pattern.sub(my_match_function, str(text))

    return value


def enforce_directive_value(directive,
                            enforced_directive_data,
                            container_name,
                            container_data):
    '''
    Enforce value of directive under conditions

    directive
        directive label (name)

    enforced_directive_data
        dict containning
            value to put
            condition (greater|lower|different)
            regex match : default= r'(\\w+(\\s+\\w+)*)'
            regex group position : default=1
            container : enforce value only on the specified container

    container_name
        the name of httpd container

    container_data
        container to parse
    '''
    d_is_present = False
    add_directive = enforced_directive_data.get('add_if_absent', False)
    enforced_data_values = enforced_directive_data.get('values', [enforced_directive_data])
    for idx_d, d_item in enumerate(container_data.get('directives', [])):
        if directive in d_item:
            d_is_present = True
            for enforced_data_value in enforced_data_values:
                if (not enforced_data_value.get('container', '')) \
                or (enforced_data_value.get('container') == container_name):
                    container_data['directives'][idx_d][directive] = \
                        _substitute_value(container_data['directives'][idx_d][directive],
                                         enforced_data_value)
            if re.match(r'(\s*)?$', container_data['directives'][idx_d][directive]) is not None:
                # delete directive from list in case of
                # the value is empty after replacement
                del container_data['directives'][idx_d]
            break
    if add_directive and not d_is_present \
    and not enforced_directive_data.get('match', '') \
    and not enforced_directive_data.get('values', ''):
        append_to_container_directives(directive,
                                       enforced_directive_data.get('value'),
                                       container_data)

    # directive is not added in subcontainers
    enforced_directive_data['add_if_absent'] = False

    for sub_container_name, sub_containers in \
                                container_data.get('containers', {}).items():
        container_to_match = enforced_directive_data.get('container', sub_container_name)
        if container_to_match == sub_container_name:
            for idx, nested_container in enumerate(sub_containers):
                container_data['containers'][sub_container_name][idx] = \
                    enforce_directive_value(directive,
                                            enforced_directive_data,
                                            sub_container_name,
                                            nested_container)

    return container_data


def remove_container(container_data,
                     container_name_to_remove,
                     item_name_to_remove):
    '''
    remove container_name/item from container_data
    '''
    for idx, container in enumerate(container_data.get('containers', {}).get(container_name_to_remove, [])):
        if container.get('item') == item_name_to_remove:
            del container_data['containers'][container_name_to_remove][idx]

    for sub_container_name, sub_containers in \
                                container_data.get('containers', {}).items():
        for sub_idx, sub_container in enumerate(sub_containers):
            container_data['containers'][sub_container_name][sub_idx] = \
                remove_container(sub_container, container_name_to_remove, item_name_to_remove)

    return container_data
