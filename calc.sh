function help()
{
   # Display Help
   echo "usage calc.sh [operation] [first operator] [second operator]"
   echo "operations:"
   echo "-a Add"
   echo "-s Subtract"
   echo "-m Multiply"
   echo "-d Divide"
   echo "-% Modulo"
}

# check to make sure at least one argument is entered with -z to make sure each is all are not null (empty)
if [ -z ${1} ] && [ -z ${2} ] && [ -z ${3} ] 
then 
    # if it is the help flag, that is all that is needed otherwise ... 
    if [ ${1} -ne "-h" ]
    then
        echo 'Inputs cannot be blank please try again!' 
        exit 0 
        # check to make sure the arguments are numbers (positive or negative)
        # regex: ^ must start with this
        #        [+-]? positive or negative signs are optional
        #        [0-9] must be between 0-9 (a digit)
        #        + at least one digit
        #        $ must end with this
        if ! [[ ${2} =~ ^[+-]?[0-9]+$ ]] || ! [[ ${3} =~ ^[+-]?[0-9]+$ ]] 
        then 
            echo "Inputs must be numbers" 
            exit 0 
        fi
    fi
fi

# set our variables to the arguments passed in
A=${2}
B=${3}

while getopts ":hasmd%:" option; do
   case $option in
        h) # display Help
			help
            exit;;
        a) # add the operands
            echo ${2} + ${3} = $((A+B))
            exit;;
        s) # subtract the operands
            echo ${2} - ${3} = $((A-B))
            exit;;
        m) # multiply the operands
            echo ${2} \* ${3} = $((A*B))
            exit;;
        d) # divide the operands
            # check for division by zero
            if [ $B -le 0 ]
            then
                echo "Second operand must be greater than 0"
                exit
            fi
            echo $(( 100 * ${2} / ${3} )) | sed -e 's/..$/.&/;t'
            # echo ${2} / ${3} = $((A/B))
            exit;;
        %)  # modulo
            echo $((${2} % ${3} ))
            exit;;

        *) # display Help
            help
            exit;;
   esac
done
