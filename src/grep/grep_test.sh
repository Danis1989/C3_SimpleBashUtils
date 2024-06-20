decor="############################################"
start_decor=">-----------------------------> GREP"
flags=(
    "i"
    "v"
    "c"
    "l"
    "n"
    "h"
    "s"
    "o"
)
correct=0
fail=0
all=0

files=(
    "test_files/test_0_grep.txt"
    "test_files/test_1_grep.txt"
    "test_files/test_2_grep.txt"
    "test_files/test_3_grep.txt"
    "test_files/test_4_grep.txt"
    "test_files/test_5_grep.txt"
    "test_files/test_6_grep.txt"
    "test_files/test_7_grep.txt"
    "test_files/no_file.txt"
)

echo $decor
echo "###############* 1  flag *##################"
echo $decor
for flag in "${flags[@]}"
do
    for file in "${files[@]}"
    do
    ((all ++))
        if diff <(grep -$flag "int" $file) <(./s21_grep -$flag "int" $file) > /dev/null -q
        then
            echo "№" $all "OK"
            (( correct ++ ))
        else
            echo "№" $all "FAIL"
            echo {./s21_grep -$flag "int" $file}
            (( fail ++ ))
        fi
    done
done

for file in "${files[@]}"
do
    ((all ++))
    if diff <(grep -e "int" -e "d" $file) <(./s21_grep -e "int" -e "d" $file) -q
    then
        echo "№" $all "OK"
        (( correct ++ ))
    else
        echo "№" $all "FAIL"
        echo {./s21_grep -e "int" -e "d" $file}
        (( fail ++ ))
    fi
done

for file in "${files[@]}"
do
    ((all ++))
    if diff <(grep -f "test_files/test_ptrn_grep.txt" $file) <(./s21_grep -f "test_files/test_ptrn_grep.txt" $file) -q
    then
        echo "№" $all "OK"
        (( correct ++ ))
    else
        echo "№" $all "FAIL"
        echo {./s21_grep -f "test_files/test_ptrn_grep.txt" $file}
        (( fail ++ ))
    fi
done

echo $decor
echo "###############* 2 flags *##################"
echo $decor
for flag_one in "${flags[@]}"
do
    for flag_two in "${flags[@]}"
    do
        for file in "${files[@]}"
        do
            ((all ++))
            if diff <(grep -$flag_one$flag_two "int" $file) <(./s21_grep -$flag_one$flag_two "int" $file) -q
            then
                echo "№" $all "OK"
                (( correct ++ ))
            else
                echo "№" $all "FAIL"
                echo {./s21_grep -$flag_one -$flag_two "int" $file}
                (( fail ++ ))
            fi
        done
    done
done

for flag in "${flags[@]}"
do 
    for file in "${files[@]}"
    do
        ((all ++))
        if diff <(grep -$flag -e "int" -e "d" $file) <(./s21_grep -$flag -e "int" -e "d" $file) -q
        then
            echo "№" $all "OK"
            (( correct ++ ))
        else
            echo "№" $all "FAIL"
            echo {./s21_grep -$flag "int" -e "d" $file}
            (( fail ++ ))
        fi
    done
done

for flag in "${flags[@]}"
do
    for file in "${files[@]}"
    do
        ((all ++))
        if diff <(grep -$flag -f "test_files/test_ptrn_grep.txt" $file) <(./s21_grep -$flag -f "test_files/test_ptrn_grep.txt" $file) -q
        then
            echo "№" $all "OK"
            (( correct ++ ))
        else
            echo "№" $all "FAIL"
            echo {./s21_grep -$flag -f "test_files/test_ptrn_grep.txt" $file}
            (( fail ++ ))
        fi
    done
done

echo $decor
echo "CORRECT:" $correct
echo "FAILED:" $fail
echo "ALL:" $all

echo $decor
echo "###############* LEAKS *##################"
echo "            <!> Valgrind <!>"
for flag in "${flags[@]}"
do
    for file in "${files[@]}"
    do
        if valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose -q --log-file=s21_grep.log ./s21_grep -$flag "int" $file > /dev/null
        then
            echo {./s21_grep -$flag "int" $file} "= > NO LEAKS"
        fi
    done
done