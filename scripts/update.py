#!/bin/env python3
# Copyright 2020 Red Hat
#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.
""" Generate the top-level files """

import subprocess
import os
from pathlib import Path

def create_records(fn):
    return list(map(lambda f: (Path(f).name.replace('.dhall', ''), f), fn))

def create_package(kv):
    return "{" + " , ".join(map(lambda i: " = ".join(i), kv))+ "}"

def inout(command):
    return lambda stdin: subprocess.Popen(["dhall", "--ascii"] + command, stdin=subprocess.PIPE, stdout=subprocess.PIPE).communicate(
        stdin.encode('utf-8'))[0].decode('utf-8')

dhall_format = inout(["format"])
dhall_freeze = inout(["freeze", "--all"])

def write(dest, kv):
    content = dhall_format(create_package(create_records(sorted(kv))))
    if not dest.exists() or dest.read_text() != content:
        dest.write_text(content)
        print("%s: updated!" % dest)

def listdir(dname):
    return list(map(lambda s: "./" + str(s),
                    filter(lambda s: s.endswith(".dhall") and
                           not s.startswith("_") and
                           s != "package.dhall",
                           os.listdir(dname))))

write(Path("Applications/package.dhall"), listdir(Path("./Applications/")))
