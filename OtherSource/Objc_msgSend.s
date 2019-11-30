libobjc.A.dylib`objc_msgSend:
->  0x1ad566080 <+0>:   cmp    x0, #0x0                  ; =0x0     //对比x0是否是0x0，如果是，执行下一句跳转，否则跳过下一句指令继续执行
    0x1ad566084 <+4>:   b.le   0x1ad5660f8               ; <+120>   //如果x0是0 那么执行下一句，相当于return
    0x1ad566088 <+8>:   ldr    x13, [x0]                            //读取x0的地址指向的内容，放到x13中，此时x13中应该是isa
    //----------------------------------------------------------------------------------------------------------------
    0x1ad56608c <+12>:  and    x16, x13, #0xffffffff8               //x16 = x13 取高61位
    0x1ad566090 <+16>:  ldr    x11, [x16, #0x10]                    //将地址为x16+0x10 的内存单元数据读取到 x11 中，此时X16和X11 应该是在读catch
    0x1ad566094 <+20>:  and    x10, x11, #0xffffffffffff            //x11 和 #0xffffffffffff 按位与操作，放入x10
    0x1ad566098 <+24>:  and    x12, x1, x11, lsr #48                //lsr 是逻辑右移 -- 这句指令的意思是：将x11中的内容逻辑右移48位，和X1求and，结果放入x12 中
    0x1ad56609c <+28>:  add    x12, x10, x12, lsl #4                //lsl 是逻辑左移 -- 这句指令的意思是: 将x12中的内容逻辑左移4位，和x10求and，结果放入x12 中
    0x1ad5660a0 <+32>:  ldp    x17, x9, [x12]                       //ldp 从x12 中取出两个数，存入x17，x9 中
    //----------------------------------------------------------------------------------------------------------------
    0x1ad5660a4 <+36>:  cmp    x9, x1                               //此时，x9中存放的是已经找到的_CMD,这时要和X1进行对比，如果相等，执行下一条指令，
    0x1ad5660a8 <+40>:  b.ne   0x1ad5660b4               ; <+52>    //跳转到 0x1ad5660b4
    //----------------------------------------------------------------------------------------------------------------
    0x1ad5660ac <+44>:  eor    x17, x17, x16                        //此时x17是从catch中取出的函数， x16 和 x17 求异或，将结果存放到x17 中
    0x1ad5660b0 <+48>:  br     x17                                  //跳转到x17
    0x1ad5660b4 <+52>:  cbz    x9, 0x1ad5663c0           ; _objc_msgSend_uncached //cbz的意思是：如果x9 == 0x0,那么就跳转到 0x1ad5663c0，否则，继续执行
    0x1ad5660b8 <+56>:  cmp    x12, x10                             //对比x12 和 x10 ，如果相等，执行下一句跳转
    0x1ad5660bc <+60>:  b.eq   0x1ad5660c8               ; <+72>
    0x1ad5660c0 <+64>:  ldp    x17, x9, [x12, #-0x10]!              //从 [x12-0x10] 中取出值存入x17 和 x9，同时将
    0x1ad5660c4 <+68>:  b      0x1ad5660a4               ; <+36>    //跳转到 0x1ad5660a4 -- ？？？这一段有点像循环啊，没错，这一段就是循环。汇编中循环的标记，可以去找b，并且后面的指令跳转到前面的地址
    //----------------------------------------------------------------------------------------------------------------
    0x1ad5660c8 <+72>:  add    x12, x12, x11, lsr #44               //lsr是逻辑右移 -- 这句指令的意思是：将x11中的内容逻辑右移44位，和X12 求和，并将结果存放入X12
    0x1ad5660cc <+76>:  ldp    x17, x9, [x12]                       //ldp指令，取出x12指向的值。存入x9和x17
    0x1ad5660d0 <+80>:  cmp    x9, x1                               //cmp 指令，这条指令的意思是：对比x1和x9，查看是否找到了想要的方法，x1 是要发送的消息
    0x1ad5660d4 <+84>:  b.ne   0x1ad5660e0               ; <+96>    //如果上 面的查找命中了，就执行这个跳转，跳转到 0x1ad5660e0
    0x1ad5660d8 <+88>:  eor    x17, x17, x16                        //如果上面的查找没有命中，就执行这里， x16 和 x17 求异或，将结果放入x17 
    0x1ad5660dc <+92>:  br     x17                                  //跳转到x17
    0x1ad5660e0 <+96>:  cbz    x9, 0x1ad5663c0           ; _objc_msgSend_uncached //cbz指令的意思是，如果x9中的值是0,则跳转到 0x1ad5663c0，否则继续执行，这里的含义应该是没有命中catch
    0x1ad5660e4 <+100>: cmp    x12, x10                             //对比x10 和 x12 如果 == 0x0 执行下一句指令,否则继续执行
    0x1ad5660e8 <+104>: b.eq   0x1ad5660f4               ; <+116>   //跳转到 0x1ad5660f4
    0x1ad5660ec <+108>: ldp    x17, x9, [x12, #-0x10]!              //将x12 偏移 -0x10 ，存入x9 和 x17
    0x1ad5660f0 <+112>: b      0x1ad5660d0               ; <+80>    //跳转到前头，这又是一个熟悉的循环了
    0x1ad5660f4 <+116>: b      0x1ad5663c0               ; _objc_msgSend_uncached   //sad，走到这里，循环结束了，如果还是没有找到，表示uncached
    0x1ad5660f8 <+120>: b.eq   0x1ad566130               ; <+176>   //跳转到0x1ad566130,0x1ad566130这句指令的意思是，将0x0 的值存入x1 ，应该是释放资源了
    0x1ad5660fc <+124>: adrp   x10, 298064                          //pc+298604定位到一个内存页，然后页+298604定位到地址,将值存入x10通用寄存器
    0x1ad566100 <+128>: add    x10, x10, #0x340          ; =0x340   //x10+0x340存入x10
    0x1ad566104 <+132>: lsr    x11, x0, #60                         //x0 逻辑右移#60 存放入x11
    0x1ad566108 <+136>: ldr    x16, [x10, x11, lsl #3]              //这句没看懂，将x10，x11 的值，逻辑左移3，然后放入x16？
    0x1ad56610c <+140>: adrp   x10, 298064                          //pc+298604定位到一个内存页，然后页+298604定位到地址,将值存入x10通用寄存器
    0x1ad566110 <+144>: add    x10, x10, #0x2a8          ; =0x2a8   //将x10 = x10 + 0x2a8
    0x1ad566114 <+148>: cmp    x10, x16                             //对比x10 和x 16
    0x1ad566118 <+152>: b.ne   0x1ad566090               ; <+16>    //跳转释放
    0x1ad56611c <+156>: adrp   x10, 298064                          //pc+298604定位到一个内存页，然后页+298604定位到地址,将值存入x10通用寄存器
    0x1ad566120 <+160>: add    x10, x10, #0x3c0          ; =0x3c0   //x10 = x10 + #0x3c0
    0x1ad566124 <+164>: ubfx   x11, x0, #52, #8                     //ubfx：有符号和无符号位域提取，从x0的第52位开始，提取宽度为8，存入x11
    0x1ad566128 <+168>: ldr    x16, [x10, x11, lsl #3]              //这句没看懂，将x10，x11 的值，逻辑左移3，然后放入x16？
    0x1ad56612c <+172>: b      0x1ad566090               ; <+16>
    0x1ad566130 <+176>: mov    x1, #0x0
    0x1ad566134 <+180>: movi   d0, #0000000000000000
    0x1ad566138 <+184>: movi   d1, #0000000000000000
    0x1ad56613c <+188>: movi   d2, #0000000000000000
    0x1ad566140 <+192>: movi   d3, #0000000000000000
    0x1ad566144 <+196>: ret    
    0x1ad566148 <+200>: nop    
    0x1ad56614c <+204>: nop    
    0x1ad566150 <+208>: nop    
    0x1ad566154 <+212>: nop    
    0x1ad566158 <+216>: nop    
    0x1ad56615c <+220>: nop    


//下面是复习一下isa指针
id 类型，就是一个结构体的指针

struct objc_object {
    Class _Nonnull isa  OBJC_ISA_AVAILABILITY;
};    

typedef struct objc_class *Class;


struct objc_class {
Class _Nonnull isa  OBJC_ISA_AVAILABILITY;                                      //isa 的第一个变量，也是一个isa
#if !__OBJC2__
    Class _Nullable super_class                              OBJC2_UNAVAILABLE; //父类
    const char * _Nonnull name                               OBJC2_UNAVAILABLE; //类名？
    long version                                             OBJC2_UNAVAILABLE; //版本？
    long info                                                OBJC2_UNAVAILABLE; // info 不知道是什么
    long instance_size                                       OBJC2_UNAVAILABLE; //实例大小？
    struct objc_ivar_list * _Nullable ivars                  OBJC2_UNAVAILABLE; //ivars 
    struct objc_method_list * _Nullable * _Nullable methodLists                    OBJC2_UNAVAILABLE; //方法列表
    struct objc_cache * _Nonnull cache                       OBJC2_UNAVAILABLE; //方法catch
    struct objc_protocol_list * _Nullable protocols          OBJC2_UNAVAILABLE; //遵守的协议
#endif

} OBJC2_UNAVAILABLE;
/* Use `Class` instead of `struct objc_class *` */


//一些指令的注解：
ADRP指令：
    想要了解ADRP，就要先了解，什么是ADR指令。
    ADR：小范围地址读取指令，将基于PC相对偏移的地址值读取到寄存器中。将有符号的21位的偏移，加上PC，结果写入通用寄存器
    ADRP：大范围的地址读取指令，以页为单位，P的意思是page，简单来讲，就是先定位到用偏移定位到哪个page，再用page+偏移定位到地址


