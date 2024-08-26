U-02(){
  local lcredit=-1
  local ucredit=-1
  local dcredit=-1
  local ocredit=-1
  local minlen=8
  local difok=10

  local my_lcredit=$(grep "lcredit" /etc/security/pwquality.conf | awk -F= '{print $2}')
  local my_ucredit=$(grep "ucredit" /etc/security/pwquality.conf | awk -F= '{print $2}')
  local my_dcredit=$(grep "dcredit" /etc/security/pwquality.conf | awk -F= '{print $2}')
  local my_ocredit=$(grep "ocredit" /etc/security/pwquality.conf | awk -F= '{print $2}')
  local my_minlen=$(grep "minlen" /etc/security/pwquality.conf | awk -F= '{print $2}')
  local my_difok=$(grep "difok" /etc/security/pwquality.conf | awk -F= '{print $2}')

if [ "$my_lcredit" != "$lcredit" ] || [ "$my_ucredit" != "$ucredit" ] || [ "$my_dcredit" != "$dcredit" ] || [ "$my_ocredit" != "$ocredit" ] || [ "$my_minlen" < "$minlen" ] || [ "$my_difok" != "$difok" ]; then
    echo "U-02: Bad"
else
    echo "U-02: Good"
fi

echo "lcredit: $my_lcredit"
echo "ucredit: $my_ucredit"
echo "dcredit: $my_dcredit"
echo "ocredit: $my_ocredit"
echo "minlen: $my_minlen"
echo "difok: $my_difok"

}

U-04(){
if [ -f /etc/shadow ] || [ $(cat /etc/passwd | awk -F: 'NR==1 {print $2}') == 'x' ]; then
    echo "U-04: Good"
else
    echo "U-04: Bad"
fi

echo "/etc/passwd: $(cat /etc/passwd)"
}

U-06(){
if [find / \( -nouser -o -nogroup \) -print -quit 2>/dev/null | grep -q .]; then
    echo "U-06: Bad"
else
    echo "U-06: Good"
fi
echo "$(find / \( -nouser -o -nogroup \) -print -quit 2>/dev/null)"
}

U-07(){
if [ "$(stat -c %U /etc/passwd)" = "root" ] && [ "$(stat -c %a /etc/passwd)" -le 644 ]; then
    echo "U-07: Good"
else
    echo "U-07: Bad"
fi

echo "owner: $(stat -c %U /etc/passwd)"
echo "auth: $(stat -c %a /etc/passwd)"
}

U-08(){
if [ "$(stat -c %U /etc/shadow)" = "root" ] && [ "$(stat -c %a /etc/shadow)" -le 400 ]; then
    echo "U-07: Good"
else
    echo "U-07: Bad"
fi
echo "owner: $(stat -c %U /etc/shadow)"
echo "auth: $(stat -c %a /etc/shadow)"
}

#U-02
#U-04
#U-06
#U-07
U-08
