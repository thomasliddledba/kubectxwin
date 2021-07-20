﻿Param(
    [Parameter(Mandatory=$false)]
    [string]$action,
    [Parameter(Mandatory=$false)]
    [string]$name,
    [Parameter(Mandatory=$false)]
    [string]$newname
    )

function usage() {
  Write-Output "
      Usage 
        kubectxwin                        : current context
        kubectxwin ls                     : list the contexts
        kubectxwin set <name> | 'n/a'     : switch context Note: 'n/a' will create/set a new empty context
        kubectxwin rn <oldname> <newname> : rename context <oldname> <newname>
        kubectxwin rm <name>              : delete context <name>
        kubectxwin help                   : display usage
        "
}

function current_context() {
    kubectl config view -o=jsonpath='{.current-context}'
}

function delete_context() {
    kubectl config delete-context $name
}

function rename_context() {
    kubectl config rename-context $name $newname
}

function get_contexts() {
    kubectl config get-contexts -o=name | Sort-Object
  }

function list_contexts() {
    $gctx = (get_contexts)
    $cur = (current_context)

    ForEach ($i in $gctx) {
        if ($i -eq $cur) {
            Write-Host "*" $i -ForegroundColor Red
        } else {
            Write-Host $i
        }
    }
}

function switch_context($context) {
    if ($context -eq 'n/a') {
        kubectl config set-context no-context
        kubectl config use-context no-context
    }
    else {
        kubectl config use-context $context
    }
    
}

function main() {
    switch ($action) {
        set { switch_context $name }
        Default { current_context }
        ls { list_contexts }
        rn { rename_context }
        rm { delete_context }
        help { usage }
    }
}

main