#!/usr/bin/env python3

import re

old_regex = re.compile(r"< CONFIG_|< # CONFIG_")
new_regex = re.compile(r"> CONFIG_|> # CONFIG_")

old = dict()
new = dict()

with open("config.diff", "r") as diff:
    lines = diff.readlines()

for line in lines:
    if old_regex.match(line):
        if "=" in line:
            key = line.split("=")

            old[key[0].removeprefix("< CONFIG_")] = key[1].strip()
        else:
            old[line.removeprefix("< # CONFIG_").removesuffix(" is not set\n")] = (
                "unset"
            )

    elif new_regex.match(line):
        if "=" in line:
            key = line.split("=")

            if key[1] == "y\n":
                value = "yes"
            elif key[1] == "n\n":
                value = "no"

            new[key[0].removeprefix("> CONFIG_")] = value
        else:
            new[line.removeprefix("> # CONFIG_").removesuffix(" is not set\n")] = (
                "unset"
            )

config_list = list()

for key in new:
    if key in old:
        config_list.append(f"{key} = lib.mkForce ({new[key]});")
    else:
        config_list.append(f"{key} = {new[key]};")

config = str()

for entry in config_list:
    config = config + entry + "\n"

config = config.strip()

print(config)
