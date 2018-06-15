# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
# 3.2.1 练习
1. 生成含有 bar 和 baz 两个动作的 Foo 控制器；
    rails generate controller Foo bar baz
2. 使用旁注 3.1 中介绍的技术删除 Foo 控制器及相关的动作。
    rails destroy controller Foo bar baz

    本章所学：
        命令生产控制器（rails generate controller ControllerName <optional action names> ），
        定义路由，rails 静态html及嵌入式ruby（主要是provide 和yield方法，实现title动态和不重复）
        遇红-变绿-重构 步骤的 测试(rails test 命令)

# 4.2.2 练习
1. 把你当前所在的省份和城市分别赋值给 province 和 city 变量。
   province = "河南"
   city = "郑州"
2. 使用字符串插值打印一个字符串（使用 puts 方法），在省份和城市之间加上逗号，例如“广东省，广
州市”。
   puts "#{province} , #{city}"
3. 把前一题中的逗号换成制表符。
    >> puts "#{province} \n #{city}"
    河南 
    郑州
    => nil
4. 如果把前一题中的双引号换成单引号，结果如何？
    >> puts '#{province} \n #{city}'
    #{province} \n #{city}
    => nil


# 4.2.3 练习
1. 字符串“racecar”有多长？
    "racecar".length   7
2. 使用 reverse 方法确认前一题中的字符串经过反转之后内容仍然一样。
    >> "racecar".reverse
    => "racecar"

3. 把字符串“racecar”赋值给变量 s。使用比较运算符 == 确认 s 与 s.reverse 相等。
    >> s = "racecar"
    => "racecar"
    >> s == s.reverse
    => true
4. 代码清单 4.9的运行结果是什么？如果把 s 变量的值改成“onomatopoeia”呢？提示：使用上箭头获取前一个命令，然后编辑。
    >> puts "Its a palindrome!" if s == s.reverse
    Its a palindrome!
    => nil
    s变量的值改成“onomatopoeia
    >> puts "Its a palindrome!" if s == s.reverse
    => nil

# 4.2.4 练习
1.把代码清单 4.10 中的 FILL_IN 换成正确的比较表达式，定义一个测试回文的方法。提示：使用代码清
单 4.9 中的比较表达式。
    >> def palindroom_tester(s)
    >> if s == s.reverse
    >> puts "Its an palingroom"
    >> else
    ?> puts "Its an palingroom"
    >> end
    >> end
2. 使用前一题定义的方法测试“racecar”和“onomatopoeia”，确认第一个词是回文，而第二个词不是。

    >> palindroom_tester("racecar")
    Its an palingroom
    => nil
    >> palindroom_tester("onomatopocia")
    Its an palingroom

3. 在 palindrome_tester("racecar") 上调用 nil? 方法，确认它的返回值是 nil（即在那个方法上调用
nil? 方法的结果是 true）。这是因为 palindrome_tester 方法是把结果打印出来的，而没有返回

    >> palindroom_tester("racecar").nil?
    Its an palingroom
    => true

# 4.3.1 练习
1. 在逗号和空格处分拆字符串“A man, a plan, a canal, Panama”，把结果赋值给变量 a。
```ruby
    >> "A man,a plan,a canal,Panama".split(",") #逗号分割
    => ["A man", "a plan", "a canal", "Panama"]

    >> "A man,a plan,a canal,Panama".split
    => ["A", "man,a", "plan,a", "canal,Panama"]

    >> a = "A man,a plan,a canal,Panama".split
    => ["A", "man,a", "plan,a", "canal,Panama"]
    >> a
    => ["A", "man,a", "plan,a", "canal,Panama"]

    >> a = "A man,a plan,a canal,Panama".split(",")
    => ["A man", "a plan", "a canal", "Panama"]
    >> a
    => ["A man", "a plan", "a canal", "Panama"]
```
2. 不指定连接符，把 a 连接起来，然后把结果赋值给变量 s。
```ruby
>> s = a.join
=> "A mana plana canalPanama"
```

`p "hello"`

3. 在空白处分拆 s，然后再连接起来。使用代码清单 4.10 中的方法确认得到的结果不是回文。使用downcase 方法，确认 s.downcase 是回文
```ruby
    >> v = s.split
    => ["A", "mana", "plana", "canalPanama"]
    >> v.join
    => "AmanaplanacanalPanama"
    >> palindroom_tester("AmanaplanacanalPanama")
    Its an palingroom
    => nil
```
```ruby
    >> s = "AmanaplanacanalPanama"
    => "AmanaplanacanalPanama"
    >> s.downcase
    => "amanaplanacanalpanama"
```
4. 创建字母 a 到 z 的值域，第 7 个元素是什么？ 把值域反过来呢？提示：两次都要把值域转换成数组。
```ruby
    >> x = ("a".."z").to_a
    => ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z"]
    >> x[7]
    => "h"
    # 值域反过来
    >>  y = x.reverse
    => ["z", "y", "x", "w", "v", "u", "t", "s", "r", "q", "p", "o", "n", "m", "l", "k", "j", "i", "h", "g", "f", "e", "d", "c", "b", "a"]
    >> y[7]
    => "s"
```
4.3.2

1. 创建值域 0..16，把前 17 个元素的平方打印出来。
```ruby
    >> x = (0..16).to_a
    => [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16]
    >> puts x[0..16].map{ |i| i**2 }
    0
    1
    4
    9
    16
    25
    36
    49
    64
    81
    100
    121
    144
    169
    196
    225
    256
```
2. 定义一个名为 yeller 的方法，它的参数是一个由字符组成的数组，返回值是一个字符串，由数组中字
符的大写形式组成。确认 yeller([’o’, ’l’, ’d’]) 的返回值是 OLD。提示：要用到 map、upcase 和
join 方法。
```ruby
    >> def yeller(s)
    >> v = s.map{ |char| char.upcase }
    >> puts v.join
    >> end
    => :yeller
    >> yeller(['o','l','d'])
    OLD
```
3. 定义一个名为 random_subdomain 的方法，返回八个随机字母组成的字符串。
 ```ruby   
    >> def random_subdomain 
    >> return ('a'..'z').to_a.shuffle[0..7].join
    >> end
    => :random_subdomain
    >> random_subdomain
    => "nbpcyfea"
```
4. 把代码清单 4.12 中的问号换成正确的方法，结合 split、shuffle 和 join 方法，把指定字符串中的字
符打乱。
```ruby
    ?> def string_shuffle(s)
    >> s.split('').shuffle.join
    >> end
    => :string_shuffle
    >> string_shuffle("foobar")
    => "ofaorb"
    >> string_shuffle("foobar")
    => "ofbora"
    >>
```