@test 'rails is version 4.2 or higher' {
  version=$(rails -v | egrep -o '[0-9]{1,}\.[0-9]{1,}')
  [ "$version" \> "4.1" ]
}
