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