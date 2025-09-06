talos-gen-and-apply:
    cd talos && talhelper genconfig
    cd talos && talhelper gencommand apply | bash