#!/usr/bin/env bash
sed -i "s/?id=.*/?id=$1"'"/' composer.json
sed -i "s/treoId' => '.*/treoId' => '$1'/" data/config.php
