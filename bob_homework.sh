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

U-05(){
if [ $(echo $PATH | grep -E '\.') ]; then
    echo "U-05: Bad"
else
    echo "U-05: Good"
fi

echo "$(echo $PATH)"
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
    echo "U-08: Good"
else
    echo "U-08: Bad"
fi
echo "owner: $(stat -c %U /etc/shadow)"
echo "auth: $(stat -c %a /etc/shadow)"
}

U-09(){
if [ "$(stat -c %U /etc/hosts)" = "root" ] && [ "$(stat -c %a /etc/hosts)" -le 600 ]; then
    echo "U-09: Good"
else
    echo "U-09: Bad"
fi
echo "owner: $(stat -c %U /etc/hosts)"
echo "auth: $(stat -c %a /etc/hosts)"
}

U-11(){
if [ "$(stat -c %U /etc/rsyslog.conf)" = "root" ] && [ "$(stat -c %a /etc/rsyslog.conf)" -le 600 ]; then
    echo "U-11: Good"
else
    echo "U-11: Bad"
fi
echo "owner: $(stat -c %U /etc/rsyslog.conf)"
echo "auth: $(stat -c %a /etc/rsyslog.conf)"
}


U-12(){
if [ "$(stat -c %U /etc/services)" = "root" ] && [ "$(stat -c %a /etc/services)" -le 600 ]; then
    echo "U-12: Good"
else
    echo "U-12: Bad"
fi
echo "owner: $(stat -c %U /etc/services)"
echo "auth: $(stat -c %a /etc/services)"
}

U-20(){
if [ !$(cat /etc/passwd | grep "ftp") ]; then
    echo "U-20: Good"
else
    echo "U-20: Bad"
fi
echo "FTP User: $(cat /etc/passwd | grep 'ftp')"
}

start(){
U-02
U-04
U-05
U-06
U-07
U-08
U-09
U-11
U-12
U-20
}

start
