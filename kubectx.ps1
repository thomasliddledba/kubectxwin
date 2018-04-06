Param(
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
        kubectx                        : current context
        kubectx ls                     : list the contexts
        kubectx set <name>             : switch to context <name>
        kubectx rn <oldname> <newname> : rename context <oldname> <newname>
        kubectx help                   : display usage"
}

function current_context() {
    kubectl config view -o=jsonpath='{.current-context}'
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
    kubectl config use-context $context
}

function main() {
    switch ($action) {
        set { switch_context $name }
        Default { current_context }
        ls { list_contexts }
        rn { rename_context }
        help { usage }
    }
}

main