############################################################
# Help                                                     #
############################################################
Help()
{
   # Display Help
   echo "Create a new Akamai POC"
   echo
   echo "Syntax: ./akamai [-h|customername]"
   echo "options:"
   echo "h     Print this Help."
   echo "customername     Create a new project called customername"
}

############################################################
############################################################
# Main program                                             #
############################################################
############################################################

function exists_in_list() {
    LIST=$1
    DELIMITER=$2
    VALUE=$3
    LIST_WHITESPACES=`echo $LIST | tr "$DELIMITER" " "`
    for x in $LIST_WHITESPACES; do
        if [ "$x" = "$VALUE" ]; then
            return 0
        fi
    done
    return 1
}
generate_email_template () {
    echo "Setup is now complete"
    echo "#########################################################################################"
    echo "################### Copy below information and send to $projectname ########################"
    echo "#########################################################################################"
    echo "Create a new DataStream:"
    echo "Destination select Custom HTTPS"
    echo "Name enter Hydrolix"
    echo "Endpoint URL https://trial.hdx-aka.live/ingest/event?table=$projectname.logs&token=$token"
    echo "Authentication Basic"
    echo "username: hydrolix"
    echo "password:pG4hqHLYjS_aVSbOiJklTsg"
    echo "Go to Custom Header and select Content-Type: application/json"
    echo "Check the box Send compressed data"
}


function update_table_settings() {
    #
    #keeping this in case its needed later; not needed yet
    #
    #token=`openssl rand -hex 20`
    #hdxcli --project $projectname --table logs table settings settings.stream.message_queue_max_rows 256
    #hdxcli --project $projectname --table logs table settings settings.stream.token_auth_enabled true
    #hdxcli --project $projectname --table logs table settings settings.stream.token_list '["'"$token"'"]'
    #generate_email_template "$token"
    echo "hi call me maybe"
}


function create_transform() {
    echo "Creating Transform $transformname in Table $tablename in project $projectname"
    hdxcli --project $projectname --table $tablename transform create -f $transformname.json $transformname
    #update_table_settings "$projectname"
}

function create_table() {
    echo "Creating Table $tablename in project $projectname"
    hdxcli --project $projectname table create $tablename
    #create_transform "$projectname"
}

function create_project() {
    echo "Creating Project $projectname"
    hdxcli project create $projectname
}


# Get the options
while getopts ":h" option; do
   case $option in
      h) # display Help
         Help
         exit;;
   esac
done

##clean up password mgmt later
##por ejemplo: ./buildtable.sh devplay gb_test_logs logs logtransform
##
hdxprofilename=$1
projectname=$2
tablename=$3
transformname=$4

echo "Project" $projectname 
echo "profile" $hdxprofilename

#build a project if none exists and move on either way
#
projectlist=`hdxcli --profile $hdxprofilename project list`

if exists_in_list "$projectlist" " " $projectname; then
    echo "Project $projectname already exist; will assume to add another table"
else
    #build it
    create_project "$projectname";

fi

#build a table if none exists and move on either way
#hdxcli --profile $hdxprofilename --project $projectname table list
#
tablelist=`hdxcli --profile $hdxprofilename --project $projectname table list`

if exists_in_list "$tablelist" " " $tablename; then
    echo "Table $tablename already exist; will move on and add a new default transform"
else
    #needsmustbuild this
    create_table "$tablename"
fi

#build the new default transform
#hdxcli --profile devplay --project gb_test_logs --table logs transform list
#
transformlist=`hdxcli --profile $hdxprofilename --project $projectname --table $tablename transform list`

if exists_in_list "$transformlist" " " $transformname; then
    echo "Table $transformname already exist; should be good to go unless you need a new tranform - hint: just rename it"
else
    #needsmustbuild this
    create_transform "$transformname"
fi

echo "Project, table, transform should be good to go unless you see an error"