### lombok 基础注解之 @Builder

@Builder 注解为类生成相对略微复杂的构建器 API

它作用于类，将其变成建造者模式
可以以链的形式调用
初始化实例对象生成的对象是不可以变的，可以在创建对象的时候进行赋值
如果需要在原来的基础上修改可以加 set 方法，final 字段可以不需要初始化
它会生成一个全参的构造函数


### lombok 基础注解之 @Accessors
属性说明
fluent 属性
>  不写默认为false，当该值为 true 时，对应字段的 getter 方法前面就没有 get，setter 方法就不会有 set。

chain 属性
> 不写默认为false，当该值为 true 时，对应字段的 setter 方法调用后，会返回当前对象。

### @PostConstruct注解的用法
@PostConstruct是java5的时候引入的注解，指的是在项目启动的时候执行这个方法，也可以理解为在spring容器启动的时候执行，可作为一些数据的常规化加载，比如数据字典之类的。

被@PostConstruct修饰的方法会在服务器加载Servle的时候运行，并且只会被服务器执行一次。PostConstruct在构造函数之后执行

也就是加载顺序

服务器加载Servlet -> servlet 构造函数的加载 -> postConstruct ->init（init是在service 中的初始化方法. 创建service 时发生的事件.） ->Service->destory->predestory->服务器卸载serlvet

### @Resource
@Resource有两个属性是比较重要的，分别是name和type；Spring将@Resource注解的name属性解析为bean的名字，而type属性则解析为bean的类型。所以如果使用name属性，则使用byName的自动注入策略，而使用type属性时则使用byType自动注入策略。默认按name进行注入。

按type进行注入的自动注入策略，这个type指的就是类的类型，可以这样理解，比如Apple.class，类型就是Apple，Person.class，类型就是Person

### @Builder
@Builder 注解为类生成相对略微复杂的构建器 API

它作用于类，将其变成建造者模式
可以以链的形式调用
初始化实例对象生成的对象是不可以变的，可以在创建对象的时候进行赋值
如果需要在原来的基础上修改可以加 set 方法，final 字段可以不需要初始化
它会生成一个全参的构造函数