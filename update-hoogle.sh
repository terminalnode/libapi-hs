#!/usr/bin/env bash
stack install hoogle # won't do anything if already installed
stack hoogle -- generate --local
