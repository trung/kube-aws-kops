#!/bin/bash

kops delete cluster ${NAME} --yes
tf destroy