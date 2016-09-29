from __future__ import print_function

import swaggeraem
import swaggeraem.configuration

print('Loading function')

def lambda_handler(event, context):
    swaggeraem.configuration.username = 'admin'
    swaggeraem.configuration.password = ''
    client = swaggeraem.ApiClient('http://host:4502/')

    sling = swaggeraem.apis.SlingApi(client)

    user_name = event['username']

    print("Creating user: " + user_name)

    opts= {
        'create_user': '',
        'reppassword': 'default'
    }

    # create user
    response = sling.post_authorizables_with_http_info(user_name, '/home/users/s', **opts)


    return str(response)
