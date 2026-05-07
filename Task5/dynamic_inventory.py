#!/usr/bin/env python3
import json

def get_inventory():
    inventory = {
        "workers": {
            "hosts": ["54.165.141.67", "44.201.226.144"],
            "vars": {
                "ansible_user": "ubuntu"
            }
        },
        "_meta": {
            "hostvars": {}
        }
    }
    return inventory

if __name__ == '__main__':
    print(json.dumps(get_inventory(), indent=2))
