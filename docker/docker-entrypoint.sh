#!/bin/bash

USERNAME=user
HOST_UID=${HOST_UID:?set HOST_UID}
HOST_UID=${HOST_GID:?set HOST_GID}

useradd -u "${HOST_UID}" -o -m "${USERNAME}"
groupmod -g "${HOST_GID}" "${USERNAME}"

gosu user "$@"

