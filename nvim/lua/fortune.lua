local list_extend = vim.list_extend

--- @param line string
--- @param max_width number
--- @return table
local format_line = function(line, max_width)
    if line == "" then
        return { " " }
    end

    local slen = require("plenary.strings").strdisplaywidth
    local formatted_line = {}

    -- split line by spaces into list of words
    local words = {}
    local target = "%S+"
    for word in line:gmatch(target) do
        table.insert(words, word)
    end

    local bufstart = ""
    local buffer = bufstart
    for i, word in ipairs(words) do
        if (slen(buffer) + slen(word)) <= max_width then
            buffer = buffer .. word .. " "
            if i == #words then
                table.insert(formatted_line, buffer:sub(1, -2))
            end
        else
            table.insert(formatted_line, buffer:sub(1, -2))
            buffer = bufstart .. word .. " "
            if i == #words then
                table.insert(formatted_line, buffer:sub(1, -2))
            end
        end
    end
    return formatted_line
end

--- @param fortune table
--- @param max_width number
--- @return table
local format_fortune = function(fortune, max_width)
    -- Converts list of strings to one formatted string (with linebreaks)
    local formatted_fortune = {} -- adds spacing between alpha-menu and footer
    for _, line in ipairs(fortune) do
        local formatted_line = format_line(line, max_width)
        formatted_fortune = list_extend(formatted_fortune, formatted_line)
    end
    return formatted_fortune
end

local get_fortune = function(fortune_list)
    -- selects an entry from fortune_list randomly
    math.randomseed(os.time())
    local ind = math.random(1, #fortune_list)
    return fortune_list[ind]
end

-- Credit to @mhinz for compiling this list in vim-startify
local fortune_list = {
    {
        "Debugging is twice as hard as writing the code in the first place. Therefore, if you write the code as cleverly as possible, you are, by definition, not smart enough to debug it.",
        "",
        "—— Brian Kernighan",
    },
    { "If you don't finish then you're just busy, not productive." },
    {
        "Adapting old programs to fit new machines usually means adapting new machines to behave like old ones.",
        "",
        "—— Alan Perlis",
    },
    { "Fools ignore complexity. Pragmatists suffer it. Some can avoid it. Geniuses remove it.", "", "—— Alan Perlis" },
    { "It is easier to change the specification to fit the program than vice versa.", "", "—— Alan Perlis" },
    { "Simplicity does not precede complexity, but follows it.", "", "—— Alan Perlis" },
    { "Optimization hinders evolution.", "", "—— Alan Perlis" },
    { "Recursion is the root of computation since it trades description for time.", "", "—— Alan Perlis" },
    {
        "It is better to have 100 functions operate on one data structure than 10 functions on 10 data structures.",
        "",
        "—— Alan Perlis",
    },
    {
        "There is nothing quite so useless as doing with great efficiency something that should not be done at all.",
        "",
        "—— Peter Drucker",
    },
    { "If you don't fail at least 90% of the time, you're not aiming high enough.", "", "—— Alan Kay" },
    {
        "I think a lot of new programmers like to use advanced data structures and advanced language features as a way of demonstrating their ability. I call it the lion-tamer syndrome. Such demonstrations are impressive, but unless they actually translate into real wins for the project, avoid them.",
        "",
        "—— Glyn Williams",
    },
    { "I would rather die of passion than of boredom.", "", "—— Vincent Van Gogh" },
    { "If a system is to serve the creative spirit, it must be entirely comprehensible to a single individual." },
    {
        "The computing scientist's main challenge is not to get confused by the complexities of his own making.",
        "",
        "—— Edsger W. Dijkstra",
    },
    {
        "Progress in a fixed context is almost always a form of optimization. Creative acts generally don't stay in the context that they are in.",
        "",
        "—— Alan Kay",
    },
    {
        "The essence of XML is this: the problem it solves is not hard, and it does not solve the problem well.",
        "",
        "—— Phil Wadler",
    },
    {
        "A good programmer is someone who always looks both ways before crossing a one-way street.",
        "",
        "—— Doug Linder",
    },
    { 'Patterns mean "I have run out of language."', "", "—— Rich Hickey" },
    {
        "Always code as if the person who ends up maintaining your code is a violent psychopath who knows where you live.",
        "",
        "—— John Woods",
    },
    {
        "Unix was not designed to stop its users from doing stupid things, as that would also stop them from doing clever things.",
    },
    {
        "Contrary to popular belief, Unix is user friendly. It just happens to be very selective about who it decides to make friends with.",
    },
    { "Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away." },
    {
        "There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies.",
        "",
        "—— C.A.R. Hoare",
    },
    { "If you don't make mistakes, you're not working on hard enough problems.", "", "—— Frank Wilczek" },
    { "If you don't start with a spec, every piece of code you write is a patch.", "", "—— Leslie Lamport" },
    {
        "Caches are bugs waiting to happen.", "",
        "—— Rob Pike"
    },
    {
        "Abstraction is not about vagueness, it is about being precise at a new semantic level.",
        "",
        "—— Edsger W. Dijkstra",
    },
    {
        "dd is horrible on purpose. It's a joke about OS/360 JCL. But today it's an internationally standardized joke. I guess that says it all.",
        "",
        "—— Rob Pike",
    },
    { "All loops are infinite ones for faulty RAM modules." },
    { "All idioms must be learned. Good idioms only need to be learned once.", "", "—— Alan Cooper" },
    {
        "For a successful technology, reality must take precedence over public relations, for Nature cannot be fooled.",
        "",
        "—— Richard Feynman",
    },
    {
        "If programmers were electricians, parallel programmers would be bomb disposal experts. Both cut wires.",
        "",
        "—— Bartosz Milewski",
    },
    {
        "Computers are harder to maintain at high altitude. Thinner air means less cushion between disk heads and platters. Also more radiation.",
    },
    { "Almost every programming language is overrated by its practitioners.", "", "—— Larry Wall" },
    { "Fancy algorithms are slow when n is small, and n is usually small.", "", "—— Rob Pike" },
    { "Methods are just functions with a special first argument.", "", "—— Andrew Gerrand" },
    { "Care about your craft.", "", "Why spend your life developing software unless you care about doing it well?" },
    {
        "Provide options, don't make lame excuses.",
        "",
        "Instead of excuses, provide options. Don't say it can't be done; explain what can be done.",
    },
    {
        "Be a catalyst for change.",
        "",
        "You can't force change on people. Instead, show them how the future might be and help them participate in creating it.",
    },
    {
        "Make quality a requirements issue.",
        "",
        "Involve your users in determining the project's real quality requirements.",
    },
    {
        "Critically analyze what you read and hear.",
        "",
        "Don't be swayed by vendors, media hype, or dogma. Analyze information in terms of you and your project.",
    },
    {
        "DRY - Don't Repeat Yourself.",
        "",
        "Every piece of knowledge must have a single, unambiguous, authoritative representation within a system.",
    },
    {
        "Eliminate effects between unrelated things.",
        "",
        "Design components that are self-contained, independent, and have a single, well-defined purpose.",
    },
    {
        "Use tracer bullets to find the target.",
        "",
        "Tracer bullets let you home in on your target by trying things and seeing how close they land.",
    },
    { "Program close to the problem domain.", "", "Design and code in your user's language." },
    {
        "Iterate the schedule with the code.",
        "",
        "Use experience you gain as you implement to refine the project time scales.",
    },
    { "Use the power of command shells.", "", "Use the shell when graphical user interfaces don't cut it." },
    {
        "Always use source code control.",
        "",
        "Source code control is a time machine for your work - you can go back.",
    },
    { "Don't panic when debugging", "", "Take a deep breath and THINK! about what could be causing the bug." },
    {
        "Don't assume it - prove it.",
        "",
        "Prove your assumptions in the actual environment - with real data and boundary conditions.",
    },
    { "Write code that writes code.", "", "Code generators increase your productivity and help avoid duplication." },
    {
        "Design With contracts.",
        "",
        "Use contracts to document and verify that code does no more and no less than it claims to do.",
    },
    {
        "Use assertions to prevent the impossible.",
        "",
        "Assertions validate your assumptions. Use them to protect your code from an uncertain world.",
    },
    {
        "Finish what you start.",
        "",
        "Where possible, the routine or object that allocates a resource should be responsible for deallocating it.",
    },
    {
        "Configure, don't integrate.",
        "",
        "Implement technology choices for an application as configuration options, not through integration or engineering.",
    },
    { "Analyze workflow to improve concurrency.", "", "Exploit concurrency in your user's workflow." },
    {
        "Always design for concurrency.",
        "",
        "Allow for concurrency, and you'll design cleaner interfaces with fewer assumptions.",
    },
    {
        "Use blackboards to coordinate workflow.",
        "",
        "Use blackboards to coordinate disparate facts and agents, while maintaining independence and isolation among participants.",
    },
    {
        "Estimate the order of your algorithms.",
        "",
        "Get a feel for how long things are likely to take before you write code.",
    },
    {
        "Refactor early, refactor often.",
        "",
        "Just as you might weed and rearrange a garden, rewrite, rework, and re-architect code when it needs it. Fix the root of the problem.",
    },
    { "Test your software, or your users will.", "", "Test ruthlessly. Don't make your users find bugs for you." },
    {
        "Don't gather requirements - dig for them.",
        "",
        "Requirements rarely lie on the surface. They're buried deep beneath layers of assumptions, misconceptions, and politics.",
    },
    {
        "Abstractions live longer than details.",
        "",
        "Invest in the abstraction, not the implementation. Abstractions can survive the barrage of changes from different implementations and new technologies.",
    },
    {
        "Don't think outside the box - find the box.",
        "",
        'When faced with an impossible problem, identify the real constraints. Ask yourself: "Does it have to be done this way? Does it have to be done at all?"',
    },
    {
        "Some things are better done than described.",
        "",
        "Don't fall into the specification spiral - at some point you need to start coding.",
    },
    {
        "Costly tools don't produce better designs.",
        "",
        "Beware of vendor hype, industry dogma, and the aura of the price tag. Judge tools on their merits.",
    },
    {
        "Don't use manual procedures.",
        "",
        "A shell script or batch file will execute the same instructions, in the same order, time after time.",
    },
    { "Coding ain't done 'til all the Tests run.", "", "'Nuff said." },
    {
        "Test state coverage, not code coverage.",
        "",
        "Identify and test significant program states. Just testing lines of code isn't enough.",
    },
    {
        "English is just a programming language.",
        "",
        "Write documents as you would write code: honor the DRY principle, use metadata, MVC, automatic generation, and so on.",
    },
    {
        "Gently exceed your users' expectations.",
        "",
        "Come to understand your users' expectations, then deliver just that little bit more.",
    },
    {
        "Think about your work.",
        "",
        "Turn off the autopilot and take control. Constantly critique and appraise your work.",
    },
    { "Don't live with broken windows.", "", "Fix bad designs, wrong decisions, and poor code when you see them." },
    {
        "Remember the big picture.",
        "",
        "Don't get so engrossed in the details that you forget to check what's happening around you.",
    },
    { "Invest regularly in your knowledge portfolio.", "", "Make learning a habit." },
    {
        "It's both what you say and the way you say it.",
        "",
        "There's no point in having great ideas if you don't communicate them effectively.",
    },
    {
        "Make it easy to reuse.",
        "",
        "If it's easy to reuse, people will. Create an environment that supports reuse.",
    },
    {
        "There are no final decisions.",
        "",
        "No decision is cast in stone. Instead, consider each as being written in the sand at the beach, and plan for change.",
    },
    {
        "Prototype to learn.",
        "",
        "Prototyping is a learning experience. Its value lies not in the code you produce, but in the lessons you learn.",
    },
    { "Estimate to avoid surprises.", "", "Estimate before you start. You'll spot potential problems up front." },
    {
        "Keep knowledge in plain text.",
        "",
        "Plain text won't become obsolete. It helps leverage your work and simplifies debugging and testing.",
    },
    {
        "Use a single editor well.",
        "",
        "The editor should be an extension of your hand; make sure your editor is configurable, extensible, and programmable.",
    },
    {
        "Fix the problem, not the blame.",
        "",
        "It doesn't really matter whether the bug is your fault or someone else's - it is still your problem, and it still needs to be fixed.",
    },
    {
        '"select" isn\'t broken.',
        "",
        "It is rare to find a bug in the OS or the compiler, or even a third-party product or library. The bug is most likely in the application.",
    },
    {
        "Learn a text manipulation language.",
        "",
        "You spend a large part of each day working with text. Why not have the computer do some of it for you?",
    },
    {
        "You can't write perfect software.",
        "",
        "Software can't be perfect. Protect your code and users from the inevitable errors.",
    },
    { "Crash early.", "", "A dead program normally does a lot less damage than a crippled one." },
    {
        "Use exceptions for exceptional problems.",
        "",
        "Exceptions can suffer from all the readability and maintainability problems of classic spaghetti code. Reserve exceptions for exceptional things.",
    },
    {
        "Minimize coupling between modules.",
        "",
        'Avoid coupling by writing "shy" code and applying the Law of Demeter.',
    },
    {
        "Put abstractions in code, details in metadata.",
        "",
        "Program for the general case, and put the specifics outside the compiled code base.",
    },
    {
        "Design using services.",
        "",
        "Design in terms of services-independent, concurrent objects behind well-defined, consistent interfaces.",
    },
    {
        "Separate views from models.",
        "",
        "Gain flexibility at low cost by designing your application in terms of models and views.",
    },
    {
        "Don't program by coincidence.",
        "",
        "Rely only on reliable things. Beware of accidental complexity, and don't confuse a happy coincidence with a purposeful plan.",
    },
    {
        "Test your estimates.",
        "",
        "Mathematical analysis of algorithms doesn't tell you everything. Try timing your code in its target environment.",
    },
    { "Design to test.", "", "Start thinking about testing before you write a line of code." },
    {
        "Don't use wizard code you don't understand.",
        "",
        "Wizards can generate reams of code. Make sure you understand all of it before you incorporate it into your project.",
    },
    {
        "Work with a user to think like a user.",
        "",
        "It's the best way to gain insight into how the system will really be used.",
    },
    {
        "Use a project glossary.",
        "",
        "Create and maintain a single source of all the specific terms and vocabulary for a project.",
    },
    {
        "Start when you're ready.",
        "",
        "You've been building experience all your life. Don't ignore niggling doubts.",
    },
    {
        "Don't be a slave to formal methods.",
        "",
        "Don't blindly adopt any technique without putting it into the context of your development practices and capabilities.",
    },
    {
        "Organize teams around functionality.",
        "",
        "Don't separate designers from coders, testers from data modelers. Build teams the way you build code.",
    },
    {
        "Test early. Test often. Test automatically.",
        "",
        "Tests that run with every build are much more effective than test plans that sit on a shelf.",
    },
    {
        "Use saboteurs to test your testing.",
        "",
        "Introduce bugs on purpose in a separate copy of the source to verify that testing will catch them.",
    },
    {
        "Find bugs once.",
        "",
        "Once a human tester finds a bug, it should be the last time a human tester finds that bug. Automatic tests should check for it from then on.",
    },
    { "Sign your work.", "", "Craftsmen of an earlier age were proud to sign their work. You should be, too." },
    { "Think twice, code once." },
    { "No matter how far down the wrong road you have gone, turn back now." },
    { "Why do we never have time to do it right, but always have time to do it over?" },
    { "Weeks of programming can save you hours of planning." },
    { "To iterate is human, to recurse divine.", "", "—— L. Peter Deutsch" },
    { "Computers are useless. They can only give you answers.", "", "—— Pablo Picasso" },
    {
        "The question of whether computers can think is like the question of whether submarines can swim.",
        "",
        "—— Edsger W. Dijkstra",
    },
    {
        "It's ridiculous to live 100 years and only be able to remember 30 million bytes. You know, less than a compact disc. The human condition is really becoming more obsolete every minute.",
        "",
        "—— Marvin Minsky",
    },
    { "The city's central computer told you? R2D2, you know better than to trust a strange computer!", "", "—— C3PO" },
    {
        "Most software today is very much like an Egyptian pyramid with millions of bricks piled on top of each other, with no structural integrity, but just done by brute force and thousands of slaves.",
        "",
        "—— Alan Kay",
    },
    {
        'I\'ve finally learned what "upward compatible" means. It means we get to keep all our old mistakes.',
        "",
        "—— Dennie van Tassel",
    },
    {
        "There are two major products that come out of Berkeley: LSD and UNIX. We don't believe this to be a coincidence.",
        "",
        "—— Jeremy S. Anderson",
    },
    {
        "The bulk of all patents are crap. Spending time reading them is stupid. It's up to the patent owner to do so, and to enforce them.",
        "",
        "—— Linus Torvalds",
    },
    { "Controlling complexity is the essence of computer programming.", "", "—— Brian Kernighan" },
    {
        "Complexity kills. It sucks the life out of developers, it makes products difficult to plan, build and test, it introduces security challenges, and it causes end-user and administrator frustration.",
        "",
        "—— Ray Ozzie",
    },
    { "The function of good software is to make the complex appear to be simple.", "", "—— Grady Booch" },
    {
        "There's an old story about the person who wished his computer were as easy to use as his telephone. That wish has come true, since I no longer know how to use my telephone.",
        "",
        "—— Bjarne Stroustrup",
    },
    { 'There are only two industries that refer to their customers as "users".', "", "—— Edward Tufte" },
    {
        "Most of you are familiar with the virtues of a programmer. There are three, of course: laziness, impatience, and hubris.",
        "",
        "—— Larry Wall",
    },
    {
        "Computer science education cannot make anybody an expert programmer any more than studying brushes and pigment can make somebody an expert painter.",
        "",
        "—— Eric S. Raymond",
    },
    { "Optimism is an occupational hazard of programming; feedback is the treatment.", "", "—— Kent Beck" },
    { "First, solve the problem. Then, write the code.", "", "—— John Johnson" },
    {
        "Measuring programming progress by lines of code is like measuring aircraft building progress by weight.",
        "",
        "—— Bill Gates",
    },
    {
        "Don't worry if it doesn't work right. If everything did, you'd be out of a job.",
        "",
        "—— Mosher's Law of Software Engineering",
    },
    { "A LISP programmer knows the value of everything, but the cost of nothing.", "", "—— Alan J. Perlis" },
    { "All problems in computer science can be solved with another level of indirection.", "", "—— David Wheeler" },
    {
        "Functions delay binding; data structures induce binding. Moral: Structure data late in the programming process.",
        "",
        "—— Alan J. Perlis",
    },
    { "Easy things should be easy and hard things should be possible.", "", "—— Larry Wall" },
    { "Nothing is more permanent than a temporary solution." },
    {
        "If you can't explain something to a six-year-old, you really don't understand it yourself.",
        "",
        "—— Albert Einstein",
    },
    { "All programming is an exercise in caching.", "", "—— Terje Mathisen" },
    { "Software is hard.", "", "—— Donald Knuth" },
    { "They did not know it was impossible, so they did it!", "", "—— Mark Twain" },
    {
        "The object-oriented model makes it easy to build up programs by accretion. What this often means, in practice, is that it provides a structured way to write spaghetti code.",
        "",
        "—— Paul Graham",
    },
    { "Question: How does a large software project get to be one year late?", "Answer: One day at a time!" },
    {
        "The first 90% of the code accounts for the first 90% of the development time. The remaining 10% of the code accounts for the other 90% of the development time.",
        "",
        "—— Tom Cargill",
    },
    {
        "In software, we rarely have meaningful requirements. Even if we do, the only measure of success that matters is whether our solution solves the customer's shifting idea of what their problem is.",
        "",
        "—— Jeff Atwood",
    },
    {
        "If debugging is the process of removing bugs, then programming must be the process of putting them in.",
        "",
        "—— Edsger W. Dijkstra",
    },
    { "640K ought to be enough for anybody.", "", "—— Bill Gates, 1981" },
    { "To understand recursion, one must first understand recursion.", "", "—— Stephen Hawking" },
    {
        "Developing tolerance for imperfection is the key factor in turning chronic starters into consistent finishers.",
        "",
        "—— Jon Acuff",
    },
    {
        "Every great developer you know got there by solving problems they were unqualified to solve until they actually did it.",
        "",
        "—— Patrick McKenzie",
    },
    {
        "The average user doesn't give a damn what happens, as long as (1) it works and (2) it's fast.",
        "",
        "—— Daniel J. Bernstein",
    },
    {
        "Walking on water and developing software from a specification are easy if both are frozen.",
        "",
        "—— Edward V. Berard",
    },
    {
        "Be curious. Read widely. Try new things. I think a lot of what people call intelligence boils down to curiosity.",
        "",
        "—— Aaron Swartz",
    },
    { "What one programmer can do in one month, two programmers can do in two months.", "", "—— Frederick P. Brooks" },
    {
        "一个人的价值, 在于他贡献了什么, 而不在于他获得了什么!",
        "",
        "—— 爱因斯坦"
    },
    {
        "你若喜爱你自己的价值, 你就得给世界创造价值!",
        "",
        "—— 歌德"
    },
    {
        "我从来不把安逸和享乐当作生活目的; ",
        "对这种伦理基础, 我称之为猪栏的理想",
        "",
        "—— 爱因斯坦",
    },
    {
        "未经反思自省的人生不值得去过",
        "",
        "The unexamined life is not worth living.",
        "",
        "—— 苏格拉底"
    },
    {
        "大多数人在20到30岁就已经过完自己的一生; ",
        "一过了这个年龄段, 他们就变成自己的影子, 以后的生命只是在不断重复自己...",
        "",
        "—— 罗曼.罗兰",
    },
    {
        "活着, 如同生命最后一天般活着; ",
        "学习, 如同永远活着般学习!",
        "",
        "—— 甘地",
    },
    {
        "人所面对的绝境, 在很多情况下都不是生存的绝境, 而是精神的绝境!"
    },
    {
        "世上只有一种英雄主义 -- 就是在认清生活的真相之后依然热爱生活",
        "",
        "—— 罗曼.罗兰"
    },
    {
        "人的一切痛苦都是源于对自己无能的愤怒",
        "",
        "—— 王小波"
    },
    {
        "Stay hungry. Stay foolish.",
        "",
        "—— 乔布斯",
    },
    {
        "人生中最大的两个财富是: 你的才华和你的时间。",
        "才华越来越多而时间越来越少。我们的一生就是用时间来换取才华。",
    },
    {
        "拥有追随自己内心与直觉的勇气 -- 你的内心与直觉多少已经知道你真正想要成为什么样的人",
        "",
        "Have the courage to follow your heart and intuition. They somehow already know what you truly want to become.",
        "",
        "—— 乔布斯",
    },
    {
        "善良比聪明重要 -- 聪明是一种天赋, 而善良是一种选择",
        "",
        "Cleverness is a gift, kindness is a choice.",
        "",
        "—— 贝佐斯"
    },
    {
        "我每天都自问: '如果今天是我生命的最后一天, 我还会做今天要做的事情吗?'",
        "如果连续很多天得到否定的回答, 那我就需要作出一些改变了。",
        "",
        "—— 乔布斯",
    },
    {
        "预测未来最好的方法就是去创造未来",
        "",
        "—— 林肯"
    },
    {
        "没有人可以回到过去, 重新开始; ",
        "但谁都可以从现在开始, 书写一个全然不同的结局!"
    },
    {
        "人生最大的痛苦不是失败",
        "而是没有经历自己想要经历的一切"
    },
    {
        "许多人所谓的成熟, 不过是被习俗磨去了棱角, 变得世故而实际了; 那不是成熟, 而是精神的早衰和个性的夭亡!",
        "真正的成熟, 应当是独特个性的形成, 真实自我的发现, 精神上的结果和丰收。",
        "",
        "—— 尼采"
    },
    {
        "这辈子没法做太多的事情, 所以每一件都要做到精彩绝伦!",
        "",
        "—— 乔布斯"
    },
    {
        "你的时间有限, 所以不要浪费时间去重复别人的生活!",
        "",
        "Your time is limited, so don`t waste it living someone else`s life.",
        "",
        "—— 乔布斯",
    },
    {
        "每个人出生的时候都是原创",
        "可悲的是很多人渐渐都成了盗版"
    },
    {
        "时间会刺破青春的华丽精致 ",
        "会把平行线刻上美人的额角 ",
        "会吃掉稀世之珍和天生丽质 ",
        "什么都逃不过它横扫的镰刀",
        "",
        "—— 莎士比亚"
    },
    {
        "死亡是生命中最好的发明 -- 它把旧的清除以便给新的让路",
        "",
        "—— 乔布斯"
    },
    {
        "一年之计 莫如树谷",
        "十年之计 莫如树木",
        "终身之计 莫如树人",
        "",
        "—— <管子>",
    },
    {
        "非淡泊无以明志",
        "非宁静无以致远",
        "",
        "—— <淮南子>刘安"
    },
    {
        "你若不想做, 总能找到借口",
        "你若想做, 总会找到方法",
        "",
        "—— 阿拉伯谚语"
    },
    {
        "想得到你从未拥有过的东西",
        "就必须做你从未做过的事情"
    },
    {
        "你若失去了财产, 你只失去了一点儿; ",
        "你若失去了荣誉, 你就失去了许多; ",
        "你若失去了勇气, 你就把一切都失去了!",
        "",
        "—— 歌德"
    },
    {
        "那不能杀死我的, 使我更强!",
        "What does not kill me, makes me stronger.",
        "",
        "—— 尼采",
    },
    {
        "对爱情的渴望, 对知识的追求, 对人类苦难不可遏制的同情心, 这三种纯洁而无比强烈的激情支配着我的一生。",
        "",
        "Three passions, simple but overwhelmingly strong, have governed my life: the longing for love, the search for knowledge, and unbearable pity for the suffering of mankind.",
        "",
        "—— <我为什么而活着>罗素"
    },
    {
        "围在城里的人想逃出来, 城外的人想冲进去; ",
        "对婚姻也罢, 职业也罢, 人生的愿望大都如此!",
        "",
        "—— <围城>钱钟书"
    },
    {
        "授人以鱼不如授人以渔!",
        "授人以鱼只救一时之急",
        "授人以渔则可解一生之需!"
    },
    {
        "兴趣是最好的老师",
        "",
        "—— 爱因斯坦",
    },
    {
        "知识上的投资总能得到最好的回报",
        "",
        "—— 富兰克林",
    },
    {
        "学习不是填满水桶, 而是点燃火焰!",
        "",
        "Education is not the filling of a pail but the lighting of a fire.",
        "",
        "—— 叶芝 (爱尔兰诗人)"
    },
    {
        "我唯一能确定的就是自己的无知",
        "",
        "I know nothing except the fact of my ignorance.",
        "",
        "—— 苏格拉底"
    },
    {
        "真正的无知不是知识的贫乏",
        "而是拒绝获取知识",
        "",
        "—— 波普尔"
    },
    {
        "读书是在别人思想的帮助下建立自己的思想",
        "—— 尼古拉.鲁巴金",
    },
    {
        "不要盲目地崇拜任何权威 -- 因为你总能找到相反的权威",
        "",
        "—— 罗素",
    },
    {
        "不必为自己的独特看法而害怕",
        "因为我们现在所接受的常识都曾是独特看法",
        "",
        "—— <自由思想的十诫>罗素"
    },
    {
        "仅仅凭借信仰跟从就等于盲从",
        "",
        "To follow by faith alone is to follow blindly.",
        "",
        "—— 富兰克林"
    },
    {
        "想象力比知识更重要!",
        "因为知识是有限的, 而想象力概括着世界的一切, 推动着进步, 并且是知识进化的源泉",
        "",
        "—— 爱因斯坦"
    },
    {
        "要打破人的偏见比崩解一个原子还难!",
        "",
        "—— 爱因斯坦"
    },
    {
        "大多数人宁愿相信美丽的谎言",
        "而不愿意直面丑陋的真相"
    },
    {
        "你要按你所想的去生活",
        "否则你迟早会按你所生活的去想"
    },
    {
        "知人者智 自知者明",
        "胜人者有力 自胜者强",
        "",
        "—— <道德经>"
    },
    {
        "大多数人宁愿死去也不愿思考",
        "事实上他们也确实到死都没有思考",
        "",
        "—— 罗素"
    },
    {
        "对知识分子而言, 成为思维的精英比成为道德的精英更重要!",
        "",
        "—— 王小波"
    },
    {
        "只有两样东西可能是无限的 -- 宇宙的大小和人类的愚蠢",
        "不过, 对于前者我不太确定",
        "",
        "—— 爱因斯坦"
    },
    {
        "没有银弹(万能药)",
        "NO silver bullet",
        "",
        "—— <人月神话>Fred Brooks",
    },
    {
        "编程的艺术就是处理复杂性的艺术",
        "",
        "—— Edsger Dijkstra"
    },

    {
        "简单即是美",
        "",
        "Simple is beautiful"
    },
    {
        "简单是可靠的先决条件",
        "",
        "Simplicity is prerequisite for reliability.",
        "",
        "—— Edsger Dijkstra"
    },
    {
        "优秀软件的作用是让复杂的东西看起来简单",
        "",
        "—— Grady Booch (UML 创始人之一)"
    },
    {
        "设计软件有两种方法: 一种是简单到极致而明显没有缺陷; 另一种是复杂到极致以至于没有明显的缺陷。前者要难得多!",
        "",
        "There are two ways of constructing a software design: One way is to make it so simple that there are obviously no deficiencies, and the other way is to make it so complicated that there are no obvious deficiencies. The first method is far more difficult.",
        "",
        "—— C.A.R.Hoare"
    },

    {
        "优秀的设计在不断地演化",
        "糟糕的设计在不断地打补丁"
    },
    {
        "最纯粹、最抽象的设计难题就是设计桥梁 -- 你面对的问题是: 如何用最少的材料, 跨越给定的距离。",
        "",
        "—— 保罗.格雷汉姆"
    },
    {
        "从不同的层次审视你的设计"
    },
    {
        "在软件可重用之前先得可用",
        "",
        "—— Ralph Johnson (设计模式四人帮之一)"
    },
    {
        "软件设计就像做爱, 一次犯错, 你要用余下的一生来维护",
        "",
        "—— Michael Sinz"
    },
    {
        "更好的工具未必能做出更好的设计"
    },

    {
        "好的程序员是那种过单行道马路都要往两边看的人",
        "",
        "—— Doug Linder"
    },
    {
        "好的程序代码本身就是最好的文档",
        "",
        "—— <代码大全>Steve McConnell"
    },
    {
        "程序必须首先让人类可以理解 然后顺便让机器能执行",
        "",
        "—— <SICP>"
    },
    {
        "假如程序代码和注释不一致, 那么很可能两者都是错的!",
        "",
        "When code and comments disagree, both are probably wrong.",
        "",
        "—— Norm Schryer (贝尔实验室科学家)"
    },
    {
        "你写下的任何代码, 六个月后再去看, 都像是别人写的",
        "",
        "—— Tom Cargill (贝尔实验室科学家)"
    },
    {
        "程序员花90%的时间完成90%的代码量, ",
        "但是剩下的10%代码要再花费90%的开发时间 (90-90法则)",
        "",
        "—— Tom Cargill (贝尔实验室科学家)"
    },

    {
        "不能影响你编程观点的语言, 不值得你去学!",
        "",
        "—— Alan Perlis (第一个图灵奖得主)"
    },
    {
        "世界上只有两种编程语言 -- 要么充满了抱怨; 要么没人使用",
        "",
        "—— Bjarne Stroustrup"
    },
    {
        "没有哪种编程语言能阻止程序员写出糟糕的代码, 不管这种语言的结构有多么好!",
        "",
        "—— Larry Flon"
    },
    {
        "C 语言诡异离奇, 缺陷重重, 但却获得了巨大的成功",
        "",
        "—— Dennis Ritchie"
    },
    {
        "(相对 C 而言)在 C++ 里, 想搬起石头砸自己的脚更为困难了; ",
        "不过一旦你真这么做了, 整条腿都得报销",
        "",
        "—— Bjarne Stroustrup"
    },
    {
        "Java 与 JavaScript 的关系, 如同雷锋与雷峰塔的关系"
    },

    {
        "在理论上, 理论和实践是没有差异的; 但在实践中, 是有差异的!",
        "",
        "In theory, there is no difference between theory and practice. But in practice, there is.",
        "",
        "—— Snepscheut"
    },
    {
        "在进度落后的项目中增加人手只会导致进度更加落后",
        "",
        "—— <人月神话>Fred Brooks",
    },
    {
        "用代码行数测算软件开发进度 如同 按重量测算飞机的制造进度",
        "",
        "—— 比尔.盖茨"
    },
    {
        "在水上行走和按需求文档开发软件都很容易 -- 前提是它们都处于冻结状态",
        "",
        "—— Edward V Berard"
    },
    {
        "乐观主义是软件开发的职业病",
        "用户反馈则是其治疗方法",
        "",
        "—— Kent Beck (Extreme Programming 之父)"
    },
    {
        "软件开发是一场程序员和上帝的竞赛: ",
        "程序员要开发出更强更好、连傻瓜都会用的软件; 而上帝在努力创造更傻的傻瓜。",
        "到目前为止, 一直是上帝赢",
        "",
        "—— Rick Cook"
    },

    {
        "如果建筑工人像程序员写软件那样盖房子, 那第一只飞来的啄木鸟就能毁掉人类文明",
        "",
        "—— Gerald Weinberg"
    },
    {
        "如果说调试(debug)是去除 bug 的过程, 那么编程就是制造 bug 的过程。",
        "",
        "—— Edsger Dijkstra"
    },
    {
        "要在自己的代码里找 bug 是很难的; ",
        "而当你认为你的代码没有错误时, 找 bug 就更难了!",
        "",
        "—— <代码大全>Steve McConnel"
    },
    {
        "调试代码比写代码更困难; ",
        "因此, 如果你尽自己所能写出了最复杂的代码, 你将没有更大的智慧去调试它"
    },

    {
        "过早的优化是万恶之源",
        "",
        "Premature optimization is the root of all evil.",
        "",
        "—— Donald Knuth"
    },
    {
        "Tape is Dead, Disk is Tape, Flash is Disk, RAM Locality is King!",
        "",
        "—— Jim Gray"
    },

    {
        "软件就像性 -- 免费的时候更好",
        "",
        "Software is like sex, it`s better when it`s free.",
        "",
        "—— Linus Torvalds"
    },

    {
        "关于工具，一个最重要的，也是最不易察觉的方面是，工具对使用此工具的人的习惯的潜移默化的影响。如果这个工具是一门程序语言，不管我们是否喜欢它，它都会影响我们的思维惯式。",
        "",
        "A most important, but also most elusive, aspect of any tool is its influence on the habits of those who train themselves in its use. If the tool is a programming language this influence is, whether we like it or not, an influence on our thinking habits. — Edsger Dijkstra, computer scientist",
        "",
        "—— Edsger Dijkstra"
    },
}

local box_chars = {
    top_bottom    = '─',
    sides         = '│',
    top_left      = '╭',
    top_right     = '╮',
    bottom_right  = '╯',
    bottom_left   = '╰',
}

local cow = {
[[       o]],
[[        o   ^__^]],
[[         o  (oo)\_______]],
[[            (__)\       )\/\]],
[[                ||----w |]],
[[                ||     ||]],
}

local function draw_box(lines)
    local slen = require("plenary.strings").strdisplaywidth

    local max_width = 0
    for _, l in ipairs(lines) do
        max_width = math.max(max_width, slen(l))
    end

    local top_bottom_border = string.rep(box_chars.top_bottom, max_width + 2)
    local top = box_chars.top_left .. top_bottom_border .. box_chars.top_right
    local bottom = box_chars.bottom_left .. top_bottom_border .. box_chars.bottom_right

    local box = { top }
    for _, l in ipairs(lines) do
        local offset = max_width - slen(l)
        local formatted = ''
        if l:sub(1, string.len('——')) == '——' then
            -- 人名右对齐
            formatted = string.format('%s %s%s %s',
                                      box_chars.sides,
                                      string.rep(' ', offset),
                                      l,
                                      box_chars.sides)
        else
            -- 语录左对齐
            formatted = string.format('%s %s%s %s',
                                      box_chars.sides,
                                      l,
                                      string.rep(' ', offset),
                                      box_chars.sides)
        end
        table.insert(box, formatted)
    end
    table.insert(box, bottom)
    return box
end

local function cowsay(lines)
    local List = require 'plenary.collections.py_list'
    local box = List(draw_box(lines))
    return box:concat(cow)
end

--- @return table
--- @param opts number|table? optional
--- returns an array of strings
local main = function(opts)
    local options = {
        max_width = 54,
        fortune_list = fortune_list,
    }

    if type(opts) == "number" then
        options.max_width = opts
    elseif type(opts) == "table" then
        options = vim.tbl_extend("force", options, opts)
    end

    local fortune = get_fortune(options.fortune_list)
    local formatted_fortune = format_fortune(fortune, options.max_width)

    return cowsay(formatted_fortune)
end

return main
