#!/usr/bin/env bash
###################
# DNS Info Script #
#  version 1.2 r0 #
###################
#    (c) 2014     #
# Travis M Ervin  #
#  Bluehost Inc.  #
###################

# Run all errors to a file called 'err'.
{
    COLORS=false;
    SKIPA=false;

    # Let's check to see if the alias "dinfo" is set or not.
    if [ "$1" = "-install" ]; then
        # We can install the alias!
        echo "Installing script alias \"dinfo\"";
        DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd );
        echo "Found script at \"$DIR\"";
        echo `alias dinfo='$DIR/dns_info.sh'`;
        echo `echo "alias dinfo='$DIR/dns_info.sh'" >> ~/.bashrc`;
        echo `source ~/.bashrc`;
        echo "Sourcing \"~/.bashrc\"";
        exit;
    fi

    URL=$1;

    if [ "$1" = "-skipa" ]; then
        SKIPA=true;
        URL=$2;
    fi

    if [ "$URL" = "" ] || [ "$URL" = "-h" ] || [ "$URL" = "-help" ] || [ "$URL" = "--help" ]; then
        echo "";
        echo "You need to specify a URL";
        echo "USAGE: dns_info.sh <option> <url>";
        echo "Options:";
        echo "    -host        Show just the host of the website."
        echo "    -trace       Will preform a trace and display the second to last line."
        echo "    -color       This will color all individual blocks."
        echo "";
        echo "DNS Info Script";
        echo "   (c) 2014    ";
        echo "Travis M Ervin";
        exit;
    fi

    if [ "$URL" = "-host" ]; then
        echo "Getting Info for: $2";
        IPv4=`dig a $2 | grep A | awk '{ if ($4 == "A") print $5;}' | head -n 1`;

        if [ -z "$IPv4" ]; then
            echo `echo -e "$(tput setaf 1)$(tput bold)Invalid IPv4! Aborting!"`;
            echo `echo -e "$(tput sgr0)"`;
            exit;
        fi

        # Preform a HOST on the IPv4 to find out who is hosting.
        HOST=`host $IPv4`;
        HOST=${HOST#*pointer };
        echo "The site is hosted on/by: $HOST";
        exit;
    fi

    if [ "$URL" = "-trace" ]; then
        TRACE=`traceroute $2 | tail -n 2 | head -n 1`;
        echo "$TRACE";
        exit;
    fi

    if [ "$URL" = "-color" ]; then
        COLOR=true;
        URL=$2;
    fi
    
    if [ "$URL" = "-daemon" ]; then
        URL=$2;
        if [ $SKIPA = false ]; then
            IPv4=`dig a $URL | grep A | awk '{ if ($4 == "A") print $5;}' | head -n 1`;
        fi
        IPv6=`dig aaaa $URL | grep AAAA | awk '{ if ($4 == "AAAA") print $5;}' | head -n 1`;

        if [ -z "$IPv6" ]; then
            IPv6="No IPv6 Found.";
        fi

        MXID=`dig mx $URL | grep MX | awk '{ if ($4 == "MX") print $5;}' | sort -n | head -n 1`;
        MX=`dig mx $URL | grep $MXID | awk '{ if ($4 == "MX") print $6; }' | head -n 1`;

        if [ -z "$MX" ]; then
            MX="No MX record found.";
        else
            mx_has_alpha=0;
            alpha={a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z};

            for char in "${alpha}"; do
	        if [ "$char" == "${alpha[@]}" ]; then
	            mx_has_alpha=1;
        	        break;
        	    fi
            done
        fi
        
        MX_A=`dig a $MX | grep A | awk '{ if ($4 == "A") print $5;}' | head -n 1`;
        if [ $mx_has_alpha -eq 1 ]; then
           MAIL=`whois $MX_A | grep OrgName`;
           MAIL=${MAIL#*pointer: };
           MAIL=`echo $MAIL | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
        fi

        DNS=`dig ns $URL | grep NS | awk '{ if ($4 == "NS") print $5;}' | head -n 1`;
        
        if [ "$DNS" = "" ]; then
            DNS="Was unable to find NS record.";
        fi
        
        # Preform a HOST on the IPv4 to find out who is hosting.
        HOST=`host $IPv4`;
        HOST=${HOST#*pointer };
        
        REGISTRAR=`whois $URL | grep Registrar: | awk '{$1=""; print $0}'`;
        REGISTRAR=${REGISTRAR#*: };
        REGISTRAR=`echo $REGISTRAR | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
        
        CREATE=`whois $URL | grep Creation | head -n 1`;
        
        if [ "$CREATE" != "" ]; then
            CREATE=${CREATE#*: };
            CREATE=`echo $CREATE | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
        
        else
            CREATE=`whois $URL | grep Registration | head -n 1`;
            CREATE=${CREATE#*: };
            CREATE=`echo $CREATE | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
        fi
        
        EXPIRE=`whois $URL | grep Expiration | head -n 1`;
        
        if [ "$EXPIRE" != "" ]; then
            EXPIRE=${EXPIRE#*: };
            EXPIRE=`echo $EXPIRE | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
        
        else
            EXPIRE=`whois $URL | grep Expir | head -n 1`;
            EXPIRE=${EXPIRE#*:};
            EXPIRE=`echo $EXPIRE | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
        fi
        
        echo "$IPv4~$IPv6~$MX~$MX_A~$DNS~$HOST~$REGISTRAR~$CREATE~$EXPIRE";
    else
        echo "Getting Info for: $URL";

        if [ $COLOR == true ]; then
            echo `echo -e "$(tput setaf 1)"`;
        else
            echo "";
        fi
        
        if [ $SKIPA = false ]; then
            IPv4=`dig a $URL | grep A | awk '{ if ($4 == "A") print $5;}' | head -n 1`;

            if [ -z "$IPv4" ]; then
                echo `echo -e "$(tput setaf 1)$(tput bold)Invalid IPv4! Aborting!"`;
                echo `echo -e "$(tput sgr0)"`;
                exit;
            fi
            echo "IPv4 of $URL is: $IPv4";
        fi

        IPv6=`dig aaaa $URL | grep AAAA | awk '{ if ($4 == "AAAA") print $5;}' | head -n 1`;

        if [ -z "$IPv6" ]; then
            echo "No IPv6 Found.";
        else
            echo "IPv6 of $URL is: $IPv6";
        fi

        if [ $COLOR == true ]; then
            echo `echo -e "$(tput setaf 2)"`;
        else
            echo "";
        fi

        MXID=`dig mx $URL | grep MX | awk '{ if ($4 == "MX") print $5;}' | sort -n | head -n 1`;
        MX=`dig mx $URL | grep $MXID | awk '{ if ($4 == "MX") print $6; }' | head -n 1`;

        if [ -z "$MX" ]; then
            echo "No MX record found.";
        else
            mx_has_alpha=0;
            alpha={a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z};

            for char in "${alpha}"; do
	        if [ "$char" == "${alpha[@]}" ]; then
	            mx_has_alpha=1;
        	        break;
        	    fi
            done
            echo "MX record points to: $MX";
        fi
        
        if [ $mx_has_alpha -eq 1 ]; then
           MX_A=`dig a $MX | grep A | awk '{ if ($4 == "A") print $5;}' | head -n 1`;
           echo "MX -> A record points to: $MX_A";

           MAIL=`timeout 0.5 whois $MX_A | grep OrgName`;
           MAIL=${MAIL#*pointer: };

           if [ $MX == "mx.spamexperts.com." ]; then
               MAIL=`echo "Spam Experts"`;
           elif [ -z "$MAIL" ]; then
               MAIL=`echo "Unable to find Mail host"`;
           fi

           MAIL=`echo $MAIL | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
           echo "Mail Hosted by/at: $MAIL";
        fi

        if [ $COLOR == true ]; then
            echo `echo -e "$(tput sgr0)"`;
        else
            echo "";
        fi

        DNS=`dig ns $URL | grep NS | awk '{ if ($4 == "NS") print $5;}' | head -n 1`;
        
        if [ "$DNS" != "" ]; then
            echo "Nameserver: $DNS";
        else
            echo "Was unable to find NS record.";
        fi

        if [ $COLOR == true ]; then
            echo `echo -e "$(tput sgr0)$(tput setaf 4)"`;
        else
            echo "";
        fi

        # Preform a HOST on the IPv4 to find out who is hosting.
        HOST=`host $IPv4`;
        HOST=${HOST#*pointer };
        echo "Website hosted at: $HOST";
        
        if [ $COLOR == true ]; then
            echo `echo -e "$(tput setaf 3)"`;
        else
            echo "";
        fi
        
        REGISTRAR=`timeout 0.5 whois $URL | grep Registrar: | head -n 1`;
        REGISTRAR=${REGISTRAR#*: };
        REGISTRAR=`echo $REGISTRAR | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
        echo "The registrar is: $REGISTRAR";
        
        CREATE=`timeout 0.5 whois $URL | grep Creation | head -n 1`;
        
        if [ "$CREATE" != "" ]; then
            CREATE=${CREATE#*: };
            CREATE=`echo $CREATE | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
            echo "The domain was created on: $CREATE";
        
        else
            CREATE=`timeout 0.5 whois $URL | grep Registration | head -n 1`;
            CREATE=${CREATE#*: };
            CREATE=`echo $CREATE | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
            echo "The domain was created on: $CREATE";
        fi
        
        EXPIRE=`timeout 0.5 whois $URL | grep Expiration | head -n 1`;
        
        if [ "$EXPIRE" != "" ]; then
            EXPIRE=${EXPIRE#*: };
            EXPIRE=`echo $EXPIRE | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
            echo "The domain expires: $EXPIRE";
        
        else
            EXPIRE=`timeout 0.5 whois $URL | grep Expir | head -n 1`;
            EXPIRE=${EXPIRE#*:};
            EXPIRE=`echo $EXPIRE | awk '{gsub(/^ +| +$/,"")} {print $0}'`;
            echo "The domain expires: $EXPIRE";
        fi
    fi

    echo `echo -e "$(tput sgr0)"`;
} 2>/dev/null;

