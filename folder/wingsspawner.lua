-- This script was generated using the MoonVeil Obfuscator v1.4.5 [https://moonveil.cc]

local Z,F,L=(string.char),(string.byte),(bit32 .bxor)
local ea=function(Za,zb)
    local O=''
    for e_=-1663008/-17323,(#Za- -0.00018073377914332189*-5533)+(21154-21058)do
        O=O..Z(L(F(Za,(e_-(2491-2395))+-6287/-6287),F(zb,(e_- -0.0039677619342839429*-24195)%#zb+(-5986- -5987))))
    end
    return O
end
return(function(t_,...)
    local function Kb(Oa)
        return t_[Oa-(4163-31898)]
    end
    local da=os.clock();
    print(ea('\145\148^s\156\219Sa\197','\229\251:\18')..da)
    local Ab=workspace.Dummy
    local Ob,B,C,gb,ub,H,Wa,la=Ab.Head,Ab[Kb(-2.0144792719919109*24725)],Ab[ea('\204\164\50.\160\128&7','\128\193TZ')],Ab[ea('n$\252@Hm\215M[','<M\155(')],Ab[ea('F\179\f.*\154\15=','\n\214jZ')],Ab.Torso,Ab.HumanoidRootPart,Ab.Humanoid;
    script=Ab.FindFirstChild(Ab,ea('V\147\154z\156\135r','\23\253\243'))or Ab.FindFirstChild(Ab,ea('\201\243\216\197\252\197\205','\168\157\177'));
    ArtificialHB=Instance.new(ea('$JI\18\196\187\nFb\0\192\183\18',"f#\'v\165\217"),script);
    ArtificialHB.Name=ea("\166\137\2\'\160\252\132\146\23\"\142\215",'\231\251vN\198\149');
    task.wait();
    script.WaitForChild(script,ea('\209\158\133z\212\202\243\133\144\127\250\225','\144\236\241\19\178\163'));
    frame=1.131554529612782e-06*14729;
    tf=Kb(-178051878/24334);
    allowframeloss=false;
    tossremainder=false;
    lastframe=tick();
    script.ArtificialHB.Fire(script.ArtificialHB)
    local z
    local function Ga(yb,o_)
        tf=tf+yb
        if tf>=frame then
            if allowframeloss then
                script.ArtificialHB.Fire(script.ArtificialHB);
                lastframe=tick()
            else
                for S=-22096- -22150,(math.floor(tf/frame))+-1689640/-31880 do
                    script.ArtificialHB.Fire(script.ArtificialHB)
                end
                lastframe=tick()
            end
            if tossremainder then
                tf=0
            else
                tf=tf-frame*math.floor(tf/frame)
            end
        end
    end
    z=game.GetService(game,ea('/\155;\144\197\15\152<\160\197','}\238U\195\160')).Heartbeat.connect(game.GetService(game,ea('/\155;\144\197\15\152<\160\197','}\238U\195\160')).Heartbeat,Ga);
    Swait=function(Ea)
        if Ea==0 or Ea==nil then
            ArtificialHB.Event.wait(ArtificialHB.Event)
        else
            for kb=0.016743330266789327*10870,(Ea)+4984378/27538 do
                ArtificialHB.Event.wait(ArtificialHB.Event)
            end
        end
    end;
    Lerp=function(s_,Qa,Ib)
        local P,U={s_.X,s_.Y,s_.Z,s_.toEulerAnglesXYZ(s_)},{Qa.X,Qa.Y,Qa.Z,Qa.toEulerAnglesXYZ(Qa)}
        for db,d_ in pairs(P)do
            P[db]=d_+(U[db]-d_)*Ib
        end
        return CFrame.new(P[28947-28946],P[9174-9172],P[30336+-30333])*CFrame.Angles(select(12033-12029,unpack(P)))
    end;
    newWeld=function(eb,Pa)
        return(function(vb)
            local function La(sa)
                return vb[sa+-0.88628790403198932*12004]
            end
            local Ba=Instance.new(La(33894+5302),Pa);
            Ba.Part0=eb;
            Ba.Part1=Pa
            return Ba
        end){[29869+-1312]=ea('\15q4p','X\20')}
    end
    if not C.FindFirstChild(C,ea('\208\160\235\161','\135\197'))then
        newWeld(H,C)
    end
    if not(not B.FindFirstChild(B,ea('\129\135\186\134','\214\226')))then
    else
        newWeld(H,B)
    end
    if not ub.FindFirstChild(ub,Kb(-78083+19876))then
        newWeld(H,ub)
    end
    if not gb.FindFirstChild(gb,ea("\28\v\'\n",'Kn'))then
        newWeld(H,gb)
    end
    if not(not H.FindFirstChild(H,ea('\236\52\215\53','\187Q')))then
    else
        newWeld(Wa,H)
    end
    if not(not Ob.FindFirstChild(Ob,ea('hbSc','?\a')))then
    else
        newWeld(H,Ob)
    end
    C.Weld.C1=CFrame.new(0,-3779.5+3780,0);
    B.Weld.C1=CFrame.new(0,-16380.5- -16381,Kb(-17896+-1317));
    ub.Weld.C1=CFrame.new(0,7951-7950,Kb(-45208+-8030));
    gb.Weld.C1=CFrame.new(0,Kb(15.030312802321832*-3101),0);
    H.Weld.C1=CFrame.new(0,Kb(-20052+-30418),0)
    local f_,j=ea('R\140W\141',';\232'),2766-2764;
    game.GetService(game,Kb(-820317300/21846)).Heartbeat.connect(game.GetService(game,Kb(-820317300/21846)).Heartbeat,function()
        return(function(T)
            local function ha(Gb)
                return T[Gb+421184088/-18556]
            end
            if not((Wa.Velocity*Vector3 .new(10454+-10453,0,-3.2085218339910803e-05*-31167)).magnitude>=14563+-14562 and j==27911+-27910)then
                if(H.Velocity*Vector3 .new(12110-12109,ha(47502-28823),-0.00014110342881332017*-7087)).magnitude<4.3144361032013115e-05*23178 and j==-0.00091996320147194111*-1087 then
                    f_=ea('\199o\194n','\174\v');
                    la.WalkSpeed=ha(13279-19220)
                elseif not((Wa.Velocity*Vector3 .new(26247/26247,0,5.0978792822185973e-05*19616)).magnitude>=-0.0001497454327643007*-6678 and j==ha(-487460160/-15387))then
                    if not((H.Velocity*Vector3 .new(17035/17035,0,-30566+30567)).magnitude<ha(-36765729/-9009)and j==11734+-11732)then
                    else
                        f_=ea('\162\227\167\226','\203\135');
                        la.WalkSpeed=ha(31755- -10488)
                    end
                else
                    f_=ea('\155y\128s','\236\24');
                    la.WalkSpeed=ha(222006114/13518)
                end
            else
                f_=ea('\138\55\145=','\253V');
                la.WalkSpeed=5889+-5859
            end
        end){[-11475-17164]=14595-14579,[1.6456175801970194*11877]=-0.00110048834170163*-14539,[510105800/-27400]=-27984+27985,[15509-21784]=-0.00079184400673067406*-20206,[-21109- -30091]=-22011+22013,[0.12382918412620163*-32456]=0}
    end)
    local function K(Va,W,Ra)
        local ab=Instance.new(ea('\233\165\203\176','\185\196'),Ab);
        ab.Size=W or Vector3 .new(-3.6337209302325581e-05*-27520,30957/30957,-0.00013340448239060833*-7496);
        ab.CanCollide=false;
        ab.Transparency=-28624- -28625;
        ab.Massless=true
        if Ra then
            ab.BrickColor=BrickColor.new(Ra)
        end
        ab.Material=Enum.Material.SmoothPlastic
        return ab
    end
    local Ia=K(Ab,Vector3 .new(-32544/-32544,29717+-29716,Kb(0.43457064395692557*-32409)));
    Ia.Transparency=-8882+8883;
    Ia.Name=ea('\232\207\182\220\253\199\171\222\142','\191\166\216\187');
    newWeld(H,Ia)
    local Ub=K(Ab,Vector3 .new(-2.1279312252627994e-05*-23497,-23980/-11990,Kb(-97637028/13812)),ea('\136}h\22C\162\234vd\29G\185\189','\202\15\1q+\214'));
    newWeld(Ia,Ub)
    local pa=K(Ab,Vector3 .new(27499-27498,-6754/-6754,-4.5566390230565937e-05*-21946));
    pa.Transparency=Kb(-56562- -19931);
    pa.Name=ea('OE\164fZM\185d*','\24,\202\1');
    newWeld(H,pa)
    local Ja=K(Ab,Vector3 .new(32597.5-32597,Kb(-10738- -13294),-458/-916),ea('\131{\213\205\b\211\225p\217\198\f\200\182','\193\t\188\170\96\167'));
    newWeld(pa,Ja)
    local y=K(Ab,Vector3 .new(-25074- -25075,3719+-3718,-8.2747207281754246e-05*-12085));
    y.Transparency=24955+-24954;
    y.Name=ea('\0\238\2\204\21\230\31\206d','W\135l\171');
    newWeld(Ub,y)
    local va=K(Ab,Vector3 .new(31822.5-31822,-24911- -24913,10073/20146),ea('C\165h\174','\4\202'));
    newWeld(y,va)
    local m=K(Ab,Vector3 .new(Kb(-0.40783522597858979*30733),Kb(-57079+12469),-0.00051334702258726901*-1948));
    m.Transparency=-0.00022899015342340279*-4367;
    m.Name=ea('\\\255\209aI\247\204c?','\v\150\191\6');
    newWeld(Ja,m)
    local Pb=K(Ab,Vector3 .new(-10308/-20616,-57638/-28819,4739.5-4739),ea('\162)\137\"','\229F'));
    newWeld(m,Pb)
    local Qb=K(Ab,Vector3 .new(2876/2876,Kb(-825637718/16202),-5.139274334463974e-05*-19458),ea('\15\50\b\50a1\18>$','AS~K'));
    newWeld(Ob,Qb)
    local w_=K(Ab,Vector3 .new(7.3230566438431406e-06*27311,4223.8000000000002/21119,758.60000000000002/3793),Kb(-14379-20200));
    newWeld(Qb,w_);
    w_.Weld.C1=CFrame.new(0,0,-8288+8289)
    local Xa=K(Ab,Vector3 .new(335/335,Kb(-34281+-1161),9.0682384946724098e-05*22055));
    Xa.Transparency=Kb(-24849- -20927);
    newWeld(H,Xa)
    local ja=K(Ab,Vector3 .new(-3.8945359660396464e-05*-25677,0.00010413412475268145*9603,-30750- -30751),ea('\173\183\136\190\158','\236\219'));
    newWeld(Xa,ja);
    ja.Weld.C1=CFrame.new(0,0,0)
    local q=K(Ab,Vector3 .new(-7.0086907765629382e-05*-14268,3.8156288156288156e-05*26208,-9.6292729898892634e-05*-20770));
    q.Transparency=18664+-18663;
    newWeld(Xa,q)
    local Q=K(Ab,Vector3 .new(-22328/-22328,-6875/-6875,8785/8785),Kb(819915696/-22696));
    newWeld(q,Q);
    Q.Weld.C1=CFrame.new(0,0,0)
    local N=K(Ab,Vector3 .new(15052-15051,Kb(852049504/-21652),-8.925383791503035e-05*-22408));
    N.Transparency=-21102- -21103;
    newWeld(q,N)
    local g=K(Ab,Vector3 .new(-1487/-1487,15461/15461,3.7285607755406412e-05*26820),ea('\184@\154W','\251\57'));
    newWeld(N,g);
    g.Weld.C1=CFrame.new(0,0,0)
    local na=K(Ab,Vector3 .new(-29289/-29289,30858/30858,Kb(-16289-10403)));
    na.Transparency=27408/27408;
    newWeld(N,na)
    local ua=K(Ab,Vector3 .new(22138+-22137,-0.000203210729526519*-4921,7.5052536775743021e-05*13324),ea('q^OBC','&6'));
    newWeld(na,ua);
    ua.Weld.C1=CFrame.new(0,0,0);
    Xa.Weld.C1=CFrame.new(Kb(-71914+19825),-2.050609030882172e-05*-24383,-29328+29327);
    q.Weld.C1=CFrame.new(0,Kb(16779-27706),-30425- -30423);
    N.Weld.C1=CFrame.new(0,Kb(-20184290/-24766),Kb(-1534361771/28241));
    na.Weld.C1=CFrame.new(0,0,0.00036324010170722849*-5506)
    local Jb,ob,ib=game.GetService(game,ea('\239\146l\198\155\127\204','\191\254\r')).LocalPlayer,0,{a=false,d=false,w=false,s=false}
    local E
    local sb;
    maxspeed=192780/32130
    local k,J,Aa=false,false,game.GetService(game,ea('\194\185\56\173V<\138\244\227\153\56\173i;\153\228','\151\202]\223\31R\250\129'));
    Aa.InputBegan.Connect(Aa.InputBegan,function(Vb,h)
        return(function(u_)
            local function D(x)
                return u_[x-(-41975- -17774)]
            end
            if h then
                return
            end
            if Vb.KeyCode==Enum.KeyCode.Z and j==D(2.6437301946582163*-13254)then
                j=3183+-3182
                local Sb=Jb.GetMouse(Jb)
                local function Da()
                    return(function(nb)
                        local function Mb(Cb)
                            return nb[Cb+(-2535+-30058)]
                        end
                        local fb,wa=Instance.new(ea('\244\238>\239\4\137\197\232.\255;\136','\182\129Z\150T\230'),Wa),Instance.new(ea('\211xu\131\214nc\149','\145\23\17\250'),Wa);
                        fb.Name=Mb(-1423316000/-21830);
                        fb.maxForce=Vector3 .new(math.huge,math.huge,math.huge);
                        fb.position=Wa.Position;
                        wa.maxTorque=Vector3 .new(math.huge,math.huge,math.huge);
                        wa.cframe=Wa.CFrame
                        repeat
                            wait();
                            la.PlatformStand=false
                            local Tb=wa.cframe-wa.cframe.p+fb.position
                            if not ib.w and not ib.s and not ib.a and not ib.d then
                                ob=-96008/-12001
                            end
                            if not(ib.w)then
                            else
                                Tb=Tb+workspace.CurrentCamera.CoordinateFrame.lookVector*ob;
                                ob=ob+792/7920
                            end
                            if not(ib.s)then
                            else
                                Tb=Tb-workspace.CurrentCamera.CoordinateFrame.lookVector*ob;
                                ob=ob+Mb(60263+-11988)
                            end
                            if not(ib.d)then
                            else
                                Tb=Tb*CFrame.new(ob,0,0);
                                ob=ob+3.7441964954320806e-06*26708
                            end
                            if not(ib.a)then
                            else
                                Tb=Tb*CFrame.new(-ob,0,0);
                                ob=ob+Mb(19459- -19624)
                            end
                            if ob>maxspeed then
                                ob=maxspeed
                            end
                            fb.position=Tb.p
                            if ib.w or ib.s then
                                wa.cframe=workspace.CurrentCamera.CoordinateFrame
                            else
                                wa.cframe=workspace.CurrentCamera.CoordinateFrame
                            end
                        until not k
                        if wa then
                            wa.Destroy(wa)
                        end
                        if not(fb)then
                        else
                            fb.Destroy(fb)
                        end
                        flying=false;
                        la.PlatformStand=false;
                        ob=Mb(-153815346/-4707)
                    end){[-5866+21548]=1834.8000000000002/18348,[33456-26966]=945.10000000000002/9451,[51780-19173]=ea('\140\212\"\145\212$\154','\201\132k'),[0.034371209057824502*2473]=0}
                end
                E=Sb.KeyDown.connect(Sb.KeyDown,function(n_)
                    return(function(rb)
                        local function fa_(b_)
                            return rb[b_-(8051+15220)]
                        end
                        if not(not H or not H.Parent)then
                        else
                            flying=false;
                            E.disconnect(E);
                            sb.disconnect(sb)
                            return
                        end
                        if n_==ea('s','\4')then
                            ib.w=fa_(-26927- -25227)
                        elseif n_==ea('\31','l')then
                            ib.s=true
                        elseif n_==ea('\220','\189')then
                            ib.a=true
                        elseif n_==fa_(347300467/24539)then
                            ib.d=true
                        end
                    end){[-621328422/24882]=true,[-198243556/21742]=ea('E','!')}
                end);
                sb=Sb.KeyUp.connect(Sb.KeyUp,function(l_)
                    return(function(i_)
                        local function ca(hb)
                            return i_[hb+(-24058+27543)]
                        end
                        if not(l_==ea('^',')'))then
                            if l_==ea('<','O')then
                                ib.s=false
                            elseif l_==ea('c','\2')then
                                ib.a=false
                            elseif l_==ca(-234881646/17606)then
                                ib.d=false
                            end
                        else
                            ib.w=false
                        end
                    end){[-1.2093251533742331*8150]=ea('\229','\129')}
                end)
                if not(J==true)then
                    J=true;
                    k=true;
                    Da()
                else
                    J=false;
                    k=false;
                    Da()
                end
            elseif Vb.KeyCode==Enum.KeyCode.X and j==D(57015422/-5569)then
                j=9156/4578;
                J=false;
                k=false
            end
        end){[13974+-11]=31672-31671,[0.7731649903702118*-14019]=-56158/-28079}
    end);
    task.spawn(function()
        return(function(c)
            local function I(qa)
                return c[qa+-1.4398563734290843*11697]
            end
            while I(54924+-10558)do
                Swait()
                if not(f_==ea('\254\21\251\20','\151q')and j==7682-7681)then
                    if f_==I(-177022056/-4072)and j==21070+-21069 then
                        if math.random(7355/7355,5576-5516)==-12637- -12638 then
                            wait();
                            w_.Weld.C0=Lerp(w_.Weld.C0,CFrame.new(0,0,4661/4661)*CFrame.Angles(math.rad(I(-0.43243978772622127*-14698)),math.rad(I(-36275220/-1185)),I(-0.13644985620755062*-16343)),1982.6000000000001/9913)
                        end
                        Ob.Weld.C0=Lerp(Ob.Weld.C0,CFrame.new(0,-8883/-4935,0)*CFrame.Angles(math.rad(-881600/-22040+(8176-8166)*math.sin(os.clock()*(-46356/-15452))),math.rad(I(0.15171706817016914*-21461)),0),-3.8067684342761431e-06*-26269);
                        H.Weld.C0=Lerp(H.Weld.C0,CFrame.new(0,0.00062695924764890286*3190+(14896+-14895)*math.cos(os.clock()*(-52677/-17559)),I(1.6322471434617012*4726))*CFrame.Angles(math.rad(I(12195- -3627)-(14526+-14516)*math.sin(os.clock()*(10491-10488))),math.rad(0),math.rad(0)),4.761904761904762e-05*2100);
                        B.Weld.C0=Lerp(B.Weld.C0,CFrame.new(-17532/-11688,1316/2632,0)*CFrame.Angles(math.rad(0.0012856775520699408*15556-(-0.00048590864917395527*-20580)*math.sin(os.clock()*(-26369- -26372))),math.rad(I(-35058- -20254)-(16812+-16792)*math.sin(os.clock()*(9247-9244))),math.rad(413700/27580+(0.009778357235984355*1534)*math.sin(os.clock()*(6872+-6869)))),752.40000000000009/7524);
                        C.Weld.C0=Lerp(C.Weld.C0,CFrame.new(13612.5+-13614,I(0.37023785322219965*-24595),I(22814+12420))*CFrame.Angles(math.rad(I(20427-24181)-(-21850/-2185)*math.sin(os.clock()*(0.00011169440411035407*26859))),math.rad(I(6389-16752)+(-5305- -5325)*math.sin(os.clock()*(0.00039994667377682978*7501))),math.rad(-370560/24704-(-352590/-23506)*math.sin(os.clock()*(-96144/-32048)))),244.30000000000001/2443);
                        gb.Weld.C0=Lerp(gb.Weld.C0,CFrame.new(1263/2526,(-9868.5+9868)+(-9.4042413128320875e-06*-21267)*math.sin(os.clock()*(19930+-19927)),-9.1623036649214655e-05*7640)*CFrame.Angles(math.rad((-6873- -6863)-(243470/24347)*math.sin(os.clock()*I(39693+-18568))),math.rad(0.00058234334963894717*-17172-(24085/4817)*math.sin(os.clock()*I(4123- -3938))),math.rad(32216-32211)),-2787.4000000000001/-27874);
                        ub.Weld.C0=Lerp(ub.Weld.C0,CFrame.new(-6822.5+6822,-23973.600000000002/29967+(-6.7569850332781513e-06*-29599)*math.sin(os.clock()*(-1448- -1451)),0-(-9266.3999999999996/-30888)*math.sin(os.clock()*(-0.0015915119363395225*-1885)))*CFrame.Angles(math.rad((-5127- -5117)-(-17996- -18006)*math.sin(os.clock()*(39735/13245))),math.rad(-155200/-15520+I(8363784/-26807)*math.sin(os.clock()*I(-0.24576634512325832*18660))),math.rad(I(26657+-8739)+(-23007+23017)*math.sin(os.clock()*(0.00010892850659017465*27541)))),-5.4439544885404764e-06*-18369);
                        Ia.Weld.C0=Lerp(Ia.Weld.C0,CFrame.new(-31196+31197,-3604.4000000000001/-9011,-2.4374107733556181e-05*-28719)*CFrame.Angles(math.rad(0-(-70675/-14135)*math.cos(os.clock()*(7570+-7567))),math.rad(0),math.rad(421300/21065-(-0.00057179887927419663*-26233)*math.cos(os.clock()*(-10622+10625)))),6.0182956186807896e-06*16616);
                        Ub.Weld.C0=Lerp(Ub.Weld.C0,CFrame.new(-0.00018745397335475663*-14937,0,-16179.5- -16180)*CFrame.Angles(math.rad(-7419- -7379),math.rad(0.00041164121351829747*-24293),math.rad(0)),1121.4000000000001/11214);
                        pa.Weld.C0=Lerp(pa.Weld.C0,CFrame.new(15555-15556,12009.200000000001/30023,-2897.2999999999997/-4139)*CFrame.Angles(math.rad(I(119906360/-12040)-I(-5939+-8263)*math.cos(os.clock()*I(-23410- -12005))),math.rad(0),math.rad(I(1092+-15573)+(0.00055718584005051816*26921)*math.cos(os.clock()*I(70084-22154)))),I(37154+274));
                        Ja.Weld.C0=Lerp(Ja.Weld.C0,CFrame.new(I(43005+3104),I(4.4776065276518588*5515),31249.5+-31249)*CFrame.Angles(math.rad(-816480/20412),math.rad(-16494- -16504),math.rad(0)),1946.6000000000001/19466);
                        y.Weld.C0=Lerp(y.Weld.C0,CFrame.new(0.00011693952555963916*29930,0,0)*CFrame.Angles(math.rad(0),math.rad(I(6.1608282513118704*7051)),math.rad(0)),-9.8629056119932937e-06*-10139);
                        va.Weld.C0=Lerp(va.Weld.C0,CFrame.new(74619.900000000009/27637,0.020754716981132078*-53,0-(21168/15120)*math.cos(os.clock()*(-29663- -29666)))*CFrame.Angles(math.rad(0),math.rad(I(-0.21382877902385089*-25324)+(27416-27391)*math.cos(os.clock()*(0.00022822365918600228*13145))),math.rad(0.0009130335539831089*-21905)),1497/14970);
                        m.Weld.C0=Lerp(m.Weld.C0,CFrame.new(I(-0.31614931812365177*-27351),0,0)*CFrame.Angles(math.rad(I(-2.2135806873587822*-16818)),math.rad(I(9793-11711)),math.rad(0)),1913.4000000000001/19134);
                        Pb.Weld.C0=Lerp(Pb.Weld.C0,CFrame.new(0.00017071320182094084*-15816,-33277.200000000004/30252,0-I(-174158421/-12601)*math.cos(os.clock()*(-11319+11322)))*CFrame.Angles(math.rad(0),math.rad(0-I(-35433990/26946)*math.cos(os.clock()*(-9.914405631382399e-05*-30259))),math.rad(2012-1992)),196.30000000000001/1963);
                        w_.Weld.C0=Lerp(w_.Weld.C0,CFrame.new(I(4180- -17478),0,0)*CFrame.Angles(math.rad(0),math.rad(I(18669+8075)),0),I(640197101/25687));
                        Xa.Weld.C0=Lerp(Xa.Weld.C0,CFrame.new(0,0,I(-7.1908509591736349*-2033))*CFrame.Angles(math.rad(-31246+31296),math.rad(0-(0.00031874541803461577*31373)*math.cos(os.clock()*(-21964+21967))),math.rad(0)),4.7950131862862624e-06*20855);
                        q.Weld.C0=Lerp(q.Weld.C0,CFrame.new(I(-19881- -22367)+(2294/9176)*math.cos(os.clock()*(0.00027327382036800875*10978)),875.5/-8755,0)*CFrame.Angles(math.rad(-117040/23408),math.rad(0-(-286035/-19069)*math.cos(os.clock()*(89346/29782))),math.rad(0)),4180/20900);
                        N.Weld.C0=Lerp(N.Weld.C0,CFrame.new(0+(-7.527853056308341e-05*-3321)*math.cos(os.clock()*I(-110545047/10313)),-6.6711140760507011e-06*14990,0)*CFrame.Angles(math.rad(25587-25592),math.rad(0-(-189780/-12652)*math.cos(os.clock()*I(-18701+25433))),math.rad(0)),-724.20000000000005/-3621);
                        na.Weld.C0=Lerp(na.Weld.C0,CFrame.new(0+I(268291620/7740)*math.cos(os.clock()*(-47595/-15865)),-1826.7/18267,I(-281359764/-23226))*CFrame.Angles(math.rad(-1868- -1863),math.rad(0-I(-1389519054/-28827)*math.cos(os.clock()*(-7864+7867))),math.rad(I(24985+10222))),-8.2118661465818116e-06*-24355)
                    elseif not(f_==ea('\247+\242*','\158O')and j==41752/20876)then
                        if not(f_==ea('\152\253\131\247','\239\156')and j==27649-27647)then
                        else
                            if not(math.random(-16948/-16948,-12517- -12577)==-0.00055586436909394106*-1799)then
                            else
                                wait();
                                w_.Weld.C0=Lerp(w_.Weld.C0,CFrame.new(0,0,-1922- -1923)*CFrame.Angles(math.rad(0),math.rad(0),0),-5859/-29295)
                            end
                            Ob.Weld.C0=Lerp(Ob.Weld.C0,CFrame.new(0,-0.00015804723856352622*-11389,0)*CFrame.Angles(math.rad(-117439/-16777-(-0.0041597337770382693*-1202)*math.sin(os.clock()*I(1513+-16380))),math.rad(0+(-0.0016663889351774704*-6001)*math.sin(os.clock()*I(20934+-28091))),I(24649- -19374)),-872/-10900);
                            H.Weld.C0=Lerp(H.Weld.C0,CFrame.new(0,-6073.6000000000004/7592+I(26575-31871)*math.cos(os.clock()*(29964-29954)),I(-11513- -10177))*CFrame.Angles(math.rad(-0.0010700909577314071*9345+I(-188093477/18161)*math.sin(os.clock()*(154940/15494))),math.rad(0-(-0.00037270321642875778*-26831)*math.sin(os.clock()*I(16777- -9607))),math.rad(0)),-3.9379768643859219e-06*-20315);
                            B.Weld.C0=Lerp(B.Weld.C0,CFrame.new(-26827.5/-17885,-28270.5+28271,0+I(165233520/14232)*math.cos(os.clock()*(-70360/-14072)))*CFrame.Angles(math.rad(I(20475+27614)-I(-25043+15936)*math.cos(os.clock()*(72675/14535))),math.rad(0-I(2.0570058997050147*13560)*math.sin(os.clock()*(0.00030868008396098284*16198))),math.rad(I(21931+-28340)+(25176-25156)*math.cos(os.clock()*(13835/2767)))),I(21631335/-4229));
                            C.Weld.C0=Lerp(C.Weld.C0,CFrame.new(-12609.5- -12608,-2870.5/-5741,0-(7281.5+-7281)*math.cos(os.clock()*I(-28499+14302)))*CFrame.Angles(math.rad(0+(-328250/-6565)*math.cos(os.clock()*(15048+-15043))),math.rad(0-I(30654- -8625)*math.sin(os.clock()*(-2360- -2365))),math.rad(0+(-27395- -27415)*math.cos(os.clock()*(28035/5607)))),1525.3600000000001/19067);
                            gb.Weld.C0=Lerp(gb.Weld.C0,CFrame.new(23936.5-23936,I(21838+-24642)-(-8.3441111435604332e-06*-23969)*math.sin(os.clock()*(-1060/-212)),810.80000000000007/-8108+(-6298.2000000000007/-31491)*math.sin(os.clock()*(-21866+21871)))*CFrame.Angles(math.rad(I(10684-15005)+I(-17752+7236)*math.cos(os.clock()*(22628-22623))),math.rad(I(-1.8214186369958276*-10785)+(-17257- -17267)*math.sin(os.clock()*(0.00021815960556743314*22919))),math.rad(I(38542+-2398))),I(4307- -12826));
                            ub.Weld.C0=Lerp(ub.Weld.C0,CFrame.new(I(22355- -17827),I(-1.2875635353055179*-27347)+(-1.4085498978801325e-05*-14199)*math.sin(os.clock()*(3505/701)),-1.2045290291496025e-05*8302-(-665/-3325)*math.sin(os.clock()*(-66410/-13282)))*CFrame.Angles(math.rad(0-(-20626+20666)*math.cos(os.clock()*(14649-14644))),math.rad(I(15630+10779)+(24496-24486)*math.sin(os.clock()*(-20184- -20189))),math.rad(0)),I(-31901+28581));
                            Ia.Weld.C0=Lerp(Ia.Weld.C0,CFrame.new(-20926- -20927,5644/14110,-17219.299999999999/-24599)*CFrame.Angles(math.rad(-0.00032429627707873914*30836),math.rad(-0.0041155650670837108*12149),math.rad(214380/3573+I(0.50867352839134961*17294)*math.sin(os.clock()*(-11471+11481)))),5.0045040536482838e-06*19982);
                            Ub.Weld.C0=Lerp(Ub.Weld.C0,CFrame.new(I(-12437802/5382),0,-5502.5- -5503)*CFrame.Angles(math.rad(0),math.rad(252340/-25234),math.rad(I(19451+9353))),-48.200000000000003/-482);
                            pa.Weld.C0=Lerp(pa.Weld.C0,CFrame.new(I(5884- -3626),8144/20360,8.283043426813395e-05*8451)*CFrame.Angles(math.rad(-62810/6281),math.rad(8622-8572),math.rad((45+-105)-(240/48)*math.sin(os.clock()*(4215+-4205)))),1.0053282396702524e-05*9947);
                            Ja.Weld.C0=Lerp(Ja.Weld.C0,CFrame.new(I(5508-13721),0,-14088/-28176)*CFrame.Angles(math.rad(0),math.rad(-111050/-11105),math.rad(0)),-2495.9000000000001/-24959);
                            y.Weld.C0=Lerp(y.Weld.C0,CFrame.new(5.9870281057708297e-05*-30065-(3936/9840)*math.sin(os.clock()*(-30120+30130)),161.09999999999999/-358+(-25911.5+25912)*math.sin(os.clock()*(29052-29042)),0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(I(43927-7309))),-2255.5/-22555);
                            va.Weld.C0=Lerp(va.Weld.C0,CFrame.new(-85131/-31530,19120.200000000001/-17382,0)*CFrame.Angles(math.rad(0),math.rad(I(1.7426139871240851*22678)),math.rad((19243+-19393)-(0.0020185708518368995*4954)*math.sin(os.clock()*I(-371721619/-17021)))),2851/28510);
                            m.Weld.C0=Lerp(m.Weld.C0,CFrame.new(0.00048530601240226478*3709+(-4276.8000000000002/-10692)*math.sin(os.clock()*I(-323300148/21309)),0.00046106557377049182*-976+(-17005.5- -17006)*math.sin(os.clock()*I(-808086663/-23747)),I(-22103+30379))*CFrame.Angles(math.rad(0),math.rad(I(41583+-16233)),math.rad(0)),I(34614-16889));
                            Pb.Weld.C0=Lerp(Pb.Weld.C0,CFrame.new(59761.800000000003/-22134,2690.6000000000004/-2446,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(I(-1.3278598564795272*-23690)+(-1570+1580)*math.sin(os.clock()*I(32981-7895)))),2251.8000000000002/22518);
                            w_.Weld.C0=Lerp(w_.Weld.C0,CFrame.new(0,I(-29433465/8685),0)*CFrame.Angles(math.rad(I(-711817561/-20293)),math.rad(I(-3062- -19119)),0),5482/27410);
                            Xa.Weld.C0=Lerp(Xa.Weld.C0,CFrame.new(0,0,573/2865)*CFrame.Angles(math.rad(I(-6337+21411)-(0.00024561575870707863*20357)*math.sin(os.clock()*(21824+-21814))),math.rad(0),math.rad(0)),-4.15817705517901e-06*-24049);
                            q.Weld.C0=Lerp(q.Weld.C0,CFrame.new(I(34882-11533)+I(-10320+-5087)*math.cos(os.clock()*I(-0.37514513652196713*-26699)),-3.3323336332433604e-06*30009,0)*CFrame.Angles(math.rad(-13602+13597),math.rad(0-(356580/23772)*math.cos(os.clock()*(-19112- -19115))),math.rad(0)),I(-19386+10631));
                            N.Weld.C0=Lerp(N.Weld.C0,CFrame.new(0+(8603.25+-8603)*math.cos(os.clock()*I(450919833/28301)),3.4157671813089221e-06*-29276,0)*CFrame.Angles(math.rad(4825-4830),math.rad(0-I(77409-31586)*math.cos(os.clock()*I(1946+29807))),math.rad(I(-10.23316536875859*-4366))),-6331/-31655);
                            na.Weld.C0=Lerp(na.Weld.C0,CFrame.new(0+(6017.25-6017)*math.cos(os.clock()*(-21352+21355)),I(286305840/-29808),I(3.6616058394160582*6850))*CFrame.Angles(math.rad(0.00033633795237454595*-14866),math.rad(0-I(-1.4153330852251582*-8061)*math.cos(os.clock()*I(25383+-22561))),math.rad(0)),1528.2/7641)
                        end
                    else
                        if not(math.random(23695-23694,-15045- -15105)==-30986- -30987)then
                        else
                            wait();
                            w_.Weld.C0=Lerp(w_.Weld.C0,CFrame.new(0,0,-14256+14257)*CFrame.Angles(math.rad(I(33997-18846)),math.rad(0),0),I(-10471+25494))
                        end
                        Ob.Weld.C0=Lerp(Ob.Weld.C0,CFrame.new(0,-0.0001206676945766575*-14917,I(-1.0945201507683386*-31041))*CFrame.Angles(math.rad(0+(70107/23369)*math.sin(os.clock()*(25694.5-25692))),math.rad((10171+-10191)+(11928-11925)*math.sin(os.clock()*(8.1803605902948205e-05*30561))),0),1.681944327642755e-05*11891);
                        H.Weld.C0=Lerp(H.Weld.C0,CFrame.new(0,3.5588455105163887e-05*-28099+(-1910.4000000000001/-9552)*math.cos(os.clock()*(-12678.5+12681)),0)*CFrame.Angles(math.rad(0),math.rad(89900/4495-(0.00023779327837666455*12616)*math.sin(os.clock()*(9040.5+-9038))),math.rad(0)),-1287.6000000000001/-6438);
                        B.Weld.C0=Lerp(B.Weld.C0,CFrame.new(-18610+18611,7896.2999999999993/26321+(5.4773511529824177e-06*18257)*math.sin(os.clock()*(-0.00014567066775434098*-17162)),12860.4/-18372)*CFrame.Angles(math.rad(8021+-7926),math.rad((5938-5918)-(-29672- -29677)*math.sin(os.clock()*(-9.4517958412098304e-05*-26450))),math.rad(-1953490/27907-(51166/25583)*math.sin(os.clock()*(-29412.5+29415)))),I(1.9802220237335715*23511));
                        C.Weld.C0=Lerp(C.Weld.C0,CFrame.new(19077+-19078,I(269472324/5566)+(2.2502250225022505e-05*4444)*math.sin(os.clock()*(-12741.5- -12744)),15999.199999999999/-22856)*CFrame.Angles(math.rad(-943500/-11100),math.rad(I(-1.4869901547116737*-25596)+(117270/23454)*math.sin(os.clock()*(9.416905228265783e-05*26548))),math.rad(-0.0052683073681041616*-13287-I(13435+14830)*math.sin(os.clock()*(-27942.5/-11177)))),I(28751- -2750));
                        gb.Weld.C0=Lerp(gb.Weld.C0,CFrame.new(I(-2.3966071428571429*-16800),I(18181+-13573)-I(0.49556405077899596*-27728)*math.cos(os.clock()*(-4292.5- -4295)),I(-0.42219496405328971*29349))*CFrame.Angles(math.rad(0),math.rad((14607+-14627)+(24045-24040)*math.sin(os.clock()*(-0.00017298643786327152*-14452))),math.rad((28999+-28996)-(-11530+11532)*math.cos(os.clock()*(14282.5/5713)))),-4932.8000000000002/-24664);
                        ub.Weld.C0=Lerp(ub.Weld.C0,CFrame.new(-502/1004,5.0499949500050503e-05*-19802-(-0.00043478260869565219*-460)*math.cos(os.clock()*(-5814.5+5817)),I(-0.77948553054662384*-31100))*CFrame.Angles(math.rad(0),math.rad(0.0017708517797060386*5647-I(874503000/19830)*math.sin(os.clock()*(-3435/-1374))),math.rad(0.00017919862375456958*-27902+(8.4943724782331702e-05*23545)*math.cos(os.clock()*I(42453+-26071)))),2021.2/10106);
                        Ia.Weld.C0=Lerp(Ia.Weld.C0,CFrame.new(I(300407520/-24360),1.6919758047459922e-05*23641,I(47314+713))*CFrame.Angles(math.rad(I(30392-17082)),math.rad(I(62705-20275)),math.rad((-6600- -6660)+(15300+-15295)*math.sin(os.clock()*(-24147.5+24150)))),2703.2000000000003/27032);
                        Ub.Weld.C0=Lerp(Ub.Weld.C0,CFrame.new(-9.9580339995732271e-05*-28118,0,-0.00032851511169513798*-1522)*CFrame.Angles(math.rad(0),math.rad(-0.0004524272723159752*22103),math.rad(0)),2.0597322348094749e-05*4855);
                        pa.Weld.C0=Lerp(pa.Weld.C0,CFrame.new(-2650+2649,1.2575848083755148e-05*31807,15495.199999999999/22136)*CFrame.Angles(math.rad(I(23520-27540)),math.rad(23472-23422),math.rad(-1275060/21251-I(26335+-22905)*math.sin(os.clock()*I(231754880/-15232)))),0.00011299435028248589*885);
                        Ja.Weld.C0=Lerp(Ja.Weld.C0,CFrame.new(-0.00012521801350565717*22361,0,7494.5+-7494)*CFrame.Angles(math.rad(0),math.rad(-0.00043792423910663457*-22835),math.rad(0)),-3038.9000000000001/-30389);
                        y.Weld.C0=Lerp(y.Weld.C0,CFrame.new(-0.00014188869620053603*12686-(-1.9436345966958212e-05*-20580)*math.sin(os.clock()*(9950/3980)),I(-0.35719467159060936*-30328)+(-1282.5+1283)*math.sin(os.clock()*I(383915120/22166)),0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),-3.5753870356466091e-06*-27969);
                        va.Weld.C0=Lerp(va.Weld.C0,CFrame.new(-68477.400000000009/-25362,-34727/31570,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad((13174+-13324)-(-114260/-11426)*math.sin(os.clock()*I(-1.8652238456129384*-12799)))),-298.40000000000003/-2984);
                        m.Weld.C0=Lerp(m.Weld.C0,CFrame.new(-0.00016776959642091527*-10729+(-1.3029740382422881e-05*-30699)*math.sin(os.clock()*(18882.5+-18880)),-1.4075255700478559e-05*31971+(-29038.5- -29039)*math.sin(os.clock()*(5628.5-5626)),0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad(0)),369.5/3695);
                        Pb.Weld.C0=Lerp(Pb.Weld.C0,CFrame.new(0.00015200990879405473*-17762,-6585.7000000000007/5987,0)*CFrame.Angles(math.rad(0),math.rad(0),math.rad((-8370+8520)+(-281+291)*math.sin(os.clock()*(-59962.5/-23985)))),-3.9488232506713003e-06*-25324);
                        w_.Weld.C0=Lerp(w_.Weld.C0,CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(I(2.0564721514782418*9031)),0),1.1172560192168036e-05*17901);
                        Xa.Weld.C0=Lerp(Xa.Weld.C0,CFrame.new(I(976370432/26056),0,-3171.4000000000001/-15857)*CFrame.Angles(math.rad(0),math.rad(I(-1854-9937)),math.rad(0)),-873.80000000000007/-8738);
                        q.Weld.C0=Lerp(q.Weld.C0,CFrame.new(0+I(41218-891)*math.cos(os.clock()*(82440/27480)),2951.9000000000001/-29519,0)*CFrame.Angles(math.rad(12994-12999),math.rad(0-(17896+-17881)*math.cos(os.clock()*(84414/28138))),math.rad(0)),-1220.4000000000001/-6102);
                        N.Weld.C0=Lerp(N.Weld.C0,CFrame.new(0+(507.5/2030)*math.cos(os.clock()*(18582+-18579)),-3005.7000000000003/30057,I(25490+-22069))*CFrame.Angles(math.rad(8013-8018),math.rad(0-(-902+917)*math.cos(os.clock()*(-0.00079787234042553187*-3760))),math.rad(0)),-4851.4000000000005/-24257);
                        na.Weld.C0=Lerp(na.Weld.C0,CFrame.new(I(-1.090851809553814*-25393)+(-1796/-7184)*math.cos(os.clock()*I(-5051- -2950)),222.40000000000001/-2224,0)*CFrame.Angles(math.rad(-0.00034319445397762373*14569),math.rad(0-(-3990+4005)*math.cos(os.clock()*(3540+-3537))),math.rad(0)),-1249.2/-6246)
                    end
                else
                    if math.random(-24229+24230,I(13523+4447))==26615+-26614 then
                        wait();
                        w_.Weld.C0=Lerp(w_.Weld.C0,CFrame.new(I(-28949877/-1023),0,I(1069-5672))*CFrame.Angles(math.rad(I(-14324+26612)),math.rad(0),0),-3264.2000000000003/-16321)
                    end
                    Ob.Weld.C0=Lerp(Ob.Weld.C0,CFrame.new(0,30045.600000000002/16692,0)*CFrame.Angles(math.rad((17735+-17725)+I(-31926+27130)*math.sin(os.clock()*(23184+-23181))),math.rad(I(-3499+7937)),0),120.10000000000001/1201);
                    H.Weld.C0=Lerp(H.Weld.C0,CFrame.new(I(51291+-31707),0.00031625553447185326*6324+I(415549345/10145)*math.cos(os.clock()*I(-1.3742194632097864*-27385)),0)*CFrame.Angles(math.rad(I(-626587065/-16311)-(-20101- -20111)*math.sin(os.clock()*(-0.0004921259842519685*-6096))),math.rad(I(69228+-28382)),math.rad(0)),8.8136788295434514e-06*11346);
                    B.Weld.C0=Lerp(B.Weld.C0,CFrame.new(I(973252500/27610),I(-3531632/16979),0)*CFrame.Angles(math.rad((8128+-8108)-(17726+-17716)*math.sin(os.clock()*(-23842- -23845))),math.rad((-22725- -22705)-I(37055-16030)*math.sin(os.clock()*(-23591- -23594))),math.rad((27274-27259)+I(0.6645117540687161*-22120)*math.sin(os.clock()*(47988/15996)))),6.0790273556231004e-05*1645);
                    C.Weld.C0=Lerp(C.Weld.C0,CFrame.new(I(31534+-18705),17828.5+-17828,0)*CFrame.Angles(math.rad(-0.001011378002528445*-19775-(-0.0015391719255040787*-6497)*math.sin(os.clock()*(19413/6471))),math.rad((-12069- -12089)+(7297-7277)*math.sin(os.clock()*(-7936- -7939))),math.rad((22219-22234)-(-33000/-2200)*math.sin(os.clock()*(0.00019536337587913518*15356)))),5.0895765472312706e-06*19648);
                    gb.Weld.C0=Lerp(gb.Weld.C0,CFrame.new(10403.5-10403,(-28421.5+28421)+(-5776.4000000000005/-28882)*math.sin(os.clock()*(-22386/-7462)),I(29527- -10230))*CFrame.Angles(math.rad(-0.00044113106003793728*22669-I(-149841017/11183)*math.sin(os.clock()*(18322-18319))),math.rad((7974-7984)-(-151225/-30245)*math.sin(os.clock()*(0.00015104219111871915*19862))),math.rad(-11550- -11555)),I(-5093- -5072));
                    ub.Weld.C0=Lerp(ub.Weld.C0,CFrame.new(-14877/29754,-2.4760902534897397e-05*32309+(2329.2000000000003/11646)*math.sin(os.clock()*I(47241+-12556)),0-(-7770.5999999999995/-25902)*math.sin(os.clock()*I(-33769+22036)))*CFrame.Angles(math.rad(277850/-27785-(-19778+19788)*math.sin(os.clock()*(-31725- -31728))),math.rad((-22147- -22157)+(590880/29544)*math.sin(os.clock()*(-0.00019846520243450649*-15116))),math.rad((-29582- -29577)+(0.00059206631142687976*16890)*math.sin(os.clock()*(0.00010022718161165309*29932)))),-9.5328884652049579e-05*-1049);
                    Ia.Weld.C0=Lerp(Ia.Weld.C0,CFrame.new(28374/28374,I(0.03486064760530351*22174),-0.0050724637681159417*-138)*CFrame.Angles(math.rad(0-(15169+-15164)*math.cos(os.clock()*I(48053+-9147))),math.rad(I(21609- -19328)),math.rad((-11605+11625)-(-40590/-2706)*math.cos(os.clock()*(-74565/-24855)))),7.0422535211267608e-06*14200);
                    Ub.Weld.C0=Lerp(Ub.Weld.C0,CFrame.new(0.00046893317702227427*5971,0,8599.5-8599)*CFrame.Angles(math.rad(0.018552875695732839*-2156),math.rad(-307310/30731),math.rad(0)),5.5035773252614206e-05*1817);
                    pa.Weld.C0=Lerp(pa.Weld.C0,CFrame.new(-5.6151384131618846e-05*17809,7442/18605,-9146.1999999999989/-13066)*CFrame.Angles(math.rad(0-I(11235- -30179)*math.cos(os.clock()*(0.00021792822896992591*13766))),math.rad(I(-28615790/26374)),math.rad((25529+-25549)+(-1260- -1275)*math.cos(os.clock()*(-27588- -27591)))),I(19781- -20920));
                    Ja.Weld.C0=Lerp(Ja.Weld.C0,CFrame.new(-0.00061255742725880549*4571,0,-1.6698393614534282e-05*-29943)*CFrame.Angles(math.rad(16814-16854),math.rad(29390-29380),math.rad(0)),-261.80000000000001/-2618);
                    y.Weld.C0=Lerp(y.Weld.C0,CFrame.new(40838/11668,0,I(6716- -28572))*CFrame.Angles(math.rad(0),math.rad(I(24224+20870)),math.rad(0)),-4.2977479800584499e-06*-23268);
                    va.Weld.C0=Lerp(va.Weld.C0,CFrame.new(-79218/-29340,-33938.300000000003/30853,0-(-1780.8/-1272)*math.cos(os.clock()*I(-1.3253527826224829*-25228)))*CFrame.Angles(math.rad(I(2491- -9946)),math.rad(0+(-20604- -20629)*math.cos(os.clock()*(86865/28955))),math.rad(-25216- -25196)),I(39067+-23809));
                    m.Weld.C0=Lerp(m.Weld.C0,CFrame.new(-0.00051199531889994151*6836,0,0)*CFrame.Angles(math.rad(I(0.56455882991189621*23041)),math.rad(0),math.rad(0)),-2.6888948642108095e-05*-3719);
                    Pb.Weld.C0=Lerp(Pb.Weld.C0,CFrame.new(0.0033415841584158419*-808,I(20538+17371),I(381409598/8849)-(-19350.799999999999/-13822)*math.cos(os.clock()*(-0.00071191267204556241*-4214)))*CFrame.Angles(math.rad(0),math.rad(0-(368425/14737)*math.cos(os.clock()*I(50872-21519))),math.rad(15527+-15507)),-2.3618327822390175e-05*-4234);
                    w_.Weld.C0=Lerp(w_.Weld.C0,CFrame.new(0,0,0)*CFrame.Angles(math.rad(0),math.rad(I(35262+-17174)),0),-1.1971746677840298e-05*-16706);
                    Xa.Weld.C0=Lerp(Xa.Weld.C0,CFrame.new(0,0,0)*CFrame.Angles(math.rad(-411760/-20588),math.rad(0-(16141-16131)*math.cos(os.clock()*I(-1.277359437751004*-11952))),math.rad(0)),I(841052016/17136));
                    q.Weld.C0=Lerp(q.Weld.C0,CFrame.new(0+(20573.25-20573)*math.cos(os.clock()*(-28872- -28875)),-3.5683699685983444e-06*28024,0)*CFrame.Angles(math.rad(I(1394-2913)),math.rad(0-(0.000471579476861167*31808)*math.cos(os.clock()*(-5447- -5450))),math.rad(0)),-6.5359477124183013e-05*-3060);
                    N.Weld.C0=Lerp(N.Weld.C0,CFrame.new(I(0.3597933762709648*30587)+(-24345.75- -24346)*math.cos(os.clock()*(19948-19945)),I(9725+6866),0)*CFrame.Angles(math.rad(-21767- -21762),math.rad(I(15715+-12745)-(323865/21591)*math.cos(os.clock()*I(-2687-6399))),math.rad(0)),3.8109756097560976e-05*5248);
                    na.Weld.C0=Lerp(na.Weld.C0,CFrame.new(0+(1.7183311567805347e-05*14549)*math.cos(os.clock()*(-25797+25800)),-1.6260162601626018e-05*6150,0)*CFrame.Angles(math.rad(-131055/26211),math.rad(0-(29133+-29118)*math.cos(os.clock()*(-63447/-21149))),math.rad(I(21368+-16966))),-1.3708019191226868e-05*-14590)
                end
            end
        end){[-24908- -21887]=-39993.799999999996/-28567,[-2.6992753623188408*3036]=0.00011355156863381241*-30823,[46362-28127]=0,[19483+-21251]=-9490/-949,[60702+-29342]=0.0005462093074065982*27462,[-28725+16285]=0,[-3993+-17964]=1677.9200000000001/20974,[57513-26425]=-35055/-11685,[-29.6275415896488*1082]=-10029.5- -10032,[120093792/6524]=4.6240636271155092e-05*32439,[-1.672733289212442*6044]=23538/7846,[-27412+7314]=0,[-27157- -8796]=16520+-16525,[-67598944/-2456]=true,[48552-28166]=0,[4216-6439]=332.60000000000002/1663,[31444-5856]=-675500/13510,[-41738- -16141]=-8.4000000000000004/-42,[-0.90583348831442567*16131]=0,[167947680/20382]=0,[-31393- -24061]=23503/-23503,[0.051150751223904112*-17771]=23324-23321,[-373650828/30542]=-30137/30137,[-26.001002004008015*998]=-11983- -12033,[-12818+22360]=-21097+21102,[40128-28166]=0,[-140454000/10125]=0,[-0.98412290617613807*19462]=-473.19999999999999/-169,[-808+-883]=0,[0.6986077297626293*26288]=0,[443881020/-20715]=-9.8719931554180787e-05*-30389,[6420-6880]=-16579.5+16582,[-5019+12871]=0,[-17938+-1005]=-9969- -9972,[7992606/27466]=3.0925045421160463e-06*25869,[-44836- -13127]=127140/12714,[1.0892675483214649*3932]=-13066- -13069,[-13761- -12976]=0,[-10083-8677]=0,[-20814+7402]=-18570+18575,[499850775/20745]=0,[-17441+32352]=10266+-10263,[225461106/12274]=-1890/1890,[132280584/26472]=-0.00046477040342071018*-21516,[-20636+-6925]=10931+-10928,[-2569-963]=-12856+12846,[-61025877/2277]=0,[281968227/24611]=0,[368108442/19071]=0,[469162090/22270]=-9924.2000000000007/9022,[55361+-27109]=0,[-74800160/3488]=-27252+27253,[-3780- -30040]=0,[27847-9455]=0,[0.72325131324301906*-7234]=10863/21726,[-1779+-29260]=-32729+32734,[-12542+2056]=0,[38229-10971]=-12830- -12835,[-12526- -22093]=0,[561937068/22869]=28616+-28611,[-73532665/16693]=0,[-45852- -20797]=-13260.799999999999/4736,[-18604+-10570]=3.2451728054518906e-05*30815,[24682-29236]=0,[-22646178/-8259]=0,[907833073/31019]=-26012/9290,[-22130+-8]=5.8193668528864059e-05*4296,[9745+4914]=-4.2544139544777708e-05*-4701,[100152205/-12449]=-31775/-6355,[2503725/-9975]=1784.5/-17845,[374383537/18007]=-21160+21163,[-20201346/5269]=0,[1.6112205278262337*-17771]=0,[0.037388373466763956*28779]=-30176+30171,[-1.126811246521447*-20842]=7749/30996,[-6600+-25046]=36560/-1828,[-16455-9992]=1947.1000000000001/-19471,[-181008560/-18280]=0,[-40480- -8466]=6735-6725,[-210597663/-16833]=-85614/-28538,[-12827- -27442]=31200-31050,[-24935+25413]=-30507.5/-12203,[294949044/-9501]=149815/29963,[23408+-24983]=-5834+5837,[302862736/-15416]=-15960/15960,[0.1772457627118644*23600]=0.01998001998001998*1001,[1.5871927324545778*11228]=-28896.75+28897,[1.8756015902908558*-9558]=0,[18.250392464678178*-1274]=0,[139226058/-25626]=-2338+2353,[1.0741434968239092*19206]=0,[-1.5109461077844311*20875]=13389+-13374,[-0.056366180291824906*-20012]=-1349520/-22492,[26675+-2671]=0,[134706960/16340]=-26870- -26880,[-2633+-1380]=8344.5+-8346,[-22912+21892]=0.0065419337956299879*-7643,[1105-2924]=-5350/-26750,[-7869-3558]=0,[40729-32221]=0,[-0.7459833674402403*-22967]=0,[52878+-29538]=4792.5/-9585,[50242-18995]=0,[-27079- -18298]=-292+295,[-7015+-10139]=-0.001004772670183371*-19905,[-1.3182401466544456*-16365]=-384560/19228,[-8612+-18746]=-758- -798,[0.74481143503189862*24766]=0,[-24085- -10065]=7833+-7830,[41928-28158]=0,[-4.8031076581576029*4505]=-10907+10917,[-25697+9628]=-2.7514100976750586e-05*-14538,[-79055614/9229]=0,[-499517227/27511]=643375/25735,[20643+9072]=1.092358949150691e-05*18309,[-1.0912797579902671*-15206]=16159+-16156,[2825- -5256]=1.0105092966855296e-05*19792,[39107-17043]=-0.00013651877133105802*-21975,[192591028/-5972]=-27200.75+27201,[26839+-15416]=56026/28013,[-279836172/-13188]=52980/2649,[2921- -28264]=6183.7999999999993/8834,[-544723008/26448]=-0.0036636746656896865*-5459,[1.5659830122229128*14481]=0,[-699137453/-28987]=6753/6753,[-41678+14479]=-19824+19829,[0.26786806830190779*17979]=0,[13022+13576]=0,[21640- -7341]=31909+-31894,[373399925/16295]=-3.5505959928988077e-05*19715,[-33552- -19196]=0,[-1.1573160662291948*-23011]=ea('\246I\237C','\129('),[-0.89833757477608489*-30257]=0,[1.2747148887908764*-15871]=0,[-48282+18041]=3309-3299,[579845037/-27399]=0,[-1.5118401042798175*-18412]=0,[306753658/27758]=9699-9684,[1.3795605162190443*14335]=0,[7131+-24181]=18363.5+-18363,[118059162/-20226]=0,[19198-18315]=-125.5/-1255,[-4014+26451]=-22263- -22278,[27853- -4386]=1615.4000000000001/16154,[-50019490/-28913]=0,[1590-8416]=77181/25727,[-127700720/13990]=0,[4678+-22856]=0,[1.2532448592679015*13714]=-27023- -27033,[0.43325693256286923*-30977]=0,[684461462/-23414]=1.620745542949757e-05*-12340,[-34729758/-27873]=0,[-1.5194728348574502*18590]=4459+-4456,[-0.34550368550368549*-20350]=-29406.5+29409,[-0.83889948595260422*30931]=29191.5-29191,[49915-18343]=-7088.6999999999998/-23629,[0.73086419753086418*10125]=0,[987614190/-31530]=126600/-6330,[43291+-19432]=994.90000000000009/9949,[-33106+28378]=0,[-0.059920559863816912*26435]=-3.5660794522501962e-06*-28042,[24095+-674]=0.00012224938875305622*4908,[535944780/-25690]=-7709+7699,[32732-29930]=0,[12492-32654]=-1048.1600000000001/-13102,[-119423766/7082]=2.1537798836958863e-05*4643,[-452109732/-21962]=-2.7100271002710027e-05*-3690,[3875-29803]=32238-32235,[-34070+6865]=-0.0015351550506601166*-13028,[-13543+31386]=8556-8553,[4163+-28162]=15313+-15308,[-122787090/-18870]=0,[9236+-21640]=0,[-41418- -10835]=6.8029524813769176e-06*29399,[3.2672078664532358*-8746]=279+-276,[-120702783/20087]=12111.75/-26915,[38559-27701]=0}
    end);
    print(ea('\213\198\201','\167'))
    local lb=game.GetService(game,ea('<aT\21hG\31','l\r\53')).LocalPlayer
    local v=lb.Character.Name
    local Fa,za,M,ba,Hb,a_,tb=workspace.FindFirstChild(workspace,v..Kb(-18412-24049)),workspace.FindFirstChild(workspace,lb.Name..ea('\168\242\239.\235\193\231:\252','\136\179\134\\')),{},{},{},nil,nil
    for Y,aa in pairs(Fa.GetDescendants(Fa))do
        if aa.Name==ea('\158\241\189\234','\206\158')and aa.Parent.Name==Kb(1317435032/-28474)and aa.Color==Color3 .fromRGB(468300/4683,26754-26654,0.012339585389930898*8104)then
            table.insert(M,aa)
        elseif aa.Name==ea('eOFT','5 ')and aa.Parent.Name==ea('\229\55\198,','\181X')and aa.Color==Color3 .fromRGB(Kb(682702437/-24411),-15844+15971,Kb(2.6612180188060353*-18292))then
            table.insert(ba,aa)
        elseif aa.Name==ea('\218\211\249\200','\138\188')and aa.Parent.Name==Kb(-127558552/2728)and aa.Color==Color3 .fromRGB(2277880/9185,5591+-5343,Kb(-32021- -13148))then
            table.insert(Hb,aa)
        elseif not(aa.Name==ea('Z\203\29\15s\244\6\b','\24\167rl')and aa.Parent.Name==ea('\139\227\165\238','\201\130'))then
            if aa.Name==ea('<\159P\211\21\160K\212','~\243?\176')and aa.Parent.Name==ea('8\245\208|.\253\210i','l\156\190\5')then
                tb=aa
            end
        else
            a_=aa
        end
    end
    print(ea('Bqv\150X\231\183\242Xyr\150F\179\179\170','6\30\2\247\52\199\192\155'),#M);
    print(ea('m\234k\140[\205\96\181w\226o\140E\153d\238','\25\133\31\237\55\237\23\220'),#ba)
    local function Ta(ga,ra,bb)
        return(function(ka)
            local function ya(ma)
                return ka[ma+(2865+-14435)]
            end
            local cb={[-26497- -26498]=ea('\f/[~3\23J}%','A@/\17'),[-64732/-32366]=za.MotorBlock,[ya(-89260798/-3922)]=true,[ya(-49968- -28856)]=ga,[30019-30014]=ra,[ya(-2291- -25755)]=bb,[60760/8680]=true};
            game.ReplicatedStorage.BlockRemotes.MotorLock.FireServer(game.ReplicatedStorage.BlockRemotes.MotorLock,unpack(cb))
        end){[-1.8724811083123425*-6352]=32715-32709,[-52227- -19545]=88108/22027,[-0.36898166468803589*-30324]=52914/17638}
    end
    local function Na(xa)
        return(function(p)
            local function ia(jb)
                return p[jb-539411532/-20801]
            end
            if not(not xa)then
            else
                return
            end
            xa.CanCollide=ia(-1.4167758186397985*19850)
            local Db=xa.FindFirstChild(xa,ea('c\19\230\152\31\197\192dP\2\237\177\55\197\194w','9v\148\247X\183\161\18'))
            if not Db then
                Db=Instance.new(ea('u\185\214\\q\185\192FR','7\214\178%'));
                Db.Name=ia(-7.1380839739798931*6764);
                Db.Parent=xa
            end
            Db.Force=Vector3 .new(0,xa.GetMass(xa)*workspace.Gravity,0);
            xa.AssemblyLinearVelocity=Vector3 .new(0,0,0)
        end){[1.6671639564374161*-13406]=ea('\199\52\223\51\209\147\147\v\244%\212\26\249\147\145\24','\157Q\173\\\150\225\242}'),[4015+-6206]=false}
    end
    local qb=game.Players.LocalPlayer
    for X,Ma in pairs(game.Workspace[qb.Name..ea('\222\196\200\248\157\247\192\236\138','\254\133\161\138')].GetDescendants(game.Workspace[qb.Name..ea('\222\196\200\248\157\247\192\236\138','\254\133\161\138')]))do
        if not(Ma.IsA(Ma,ea('o\212\5\202}\212\4\219','-\181v\175'))or Ma.IsA(Ma,Kb(746769375/-14751))or Ma.IsA(Ma,ea('cR\190\156Qg\187\137@','47\218\251')))then
        else
            Ma.CanCollide=false;
            Ma.Anchored=false;
            Na(Ma)
        end
    end
    local function A(ta,G,Eb)
        return(function(Ka)
            local function Ya(Sa)
                return Ka[Sa- -0.86530378295758503*5234]
            end
            if not ta then
                return
            end
            local mb=G
            if typeof(G)==ea('z\130\4\211R\130\20\194','3\236w\167')and G.IsA(G,Ya(478646619/-14223))then
                mb=G.CFrame
            elseif not(typeof(G)~=ea('\235R\16\201y\a','\168\20b'))then
            else
                return
            end
            local Ca=ta.FindFirstChild(ta,ea('u]\195\253\135GD[\211\237\184F','72\167\132\215('))
            if not Ca then
                Ca=Instance.new(ea('\160\f\211@(\243\145\n\195P\23\242','\226c\183\57x\156'));
                Ca.MaxForce=Vector3 .new(Ya(-24448+21678),Ya(11770+10769),989514+10486);
                Ca.P=2.814364516492176*17766;
                Ca.D=0.03229582980097695*24771;
                Ca.Parent=ta
            end
            local Bb=ta.FindFirstChild(ta,ea('\245c\181C\240u\163U','\183\f\209:'))
            if not Bb then
                Bb=Instance.new(ea('\28zf2\25lp$','^\21\2K'));
                Bb.MaxTorque=Vector3 .new(18398000000/18398,994797- -5203,1012874-12874);
                Bb.P=46484-16484;
                Bb.D=-0.046403712296983757*-10775;
                Bb.Parent=ta
            end
            local _b=mb
            if Eb then
                _b=mb*Eb
            end
            Ca.Position=_b.Position;
            Bb.CFrame=_b
        end){[-4812+31880]=969883+30117,[-22863- -24622]=1004174+-4174,[-741584412/25463]=ea('}\3\50\169o\3\51\184','?bA\204')}
    end
    local function Rb(Ua)
        return math.rad(Ua)
    end
    local V={CFrame.new(-21768.25+21767,0,0),CFrame.new(0.00035577059911768894*-7027,0,0),CFrame.new(-10832.75+10829,0,0),CFrame.new(-6.5043188677281718e-05*-19218,0,0),CFrame.new(-74750/-29900,0,Kb(-20882+-7518)),CFrame.new(-4093.25- -4097,0,0)}
    for xb=980-792,(-7172- -7176)+0.027027027027027029*6919 do
        local pb=M[(xb-(-9205+9392))]
        if not pb then
            break
        end
        for oa=10196-10111,(#V)+(322+-238)do
            local _a=ba[((xb-(28468-28281))-(16604+-16603))*#V+(oa- -1298808/-15462)]
            if _a then
                Ta(_a,pb,V[(oa-(-8814+8898))])
            end
        end
    end
    Ta(a_,lb.Character.Head,CFrame.new(0,0,0))
    local wb
    local r_,Fb=game.GetService(game,Kb(4.4355329949238582*985)),game.Players.LocalPlayer.Name;
    task.spawn(function()
        return(function(Lb)
            local function Nb(Ha)
                return Lb[Ha-(-9908- -13045)]
            end
            while true do
                Swait()
                if Ub then
                    M[3.4696922382984629e-05*28821].CFrame=Ub.CFrame
                end
                if not(Ja)then
                else
                    M[25936-25934].CFrame=Ja.CFrame
                end
                if not(va)then
                else
                    M[-0.00012884384126438757*-23284].CFrame=va.CFrame
                end
                if not(Pb)then
                else
                    M[0.00015493666963628617*25817].CFrame=Pb.CFrame
                end
                if w_ then
                    tb.CFrame=Lerp(tb.CFrame,w_.CFrame,3.0799556486386595e-05*32468)
                end
                local R=CFrame.Angles(math.rad(865+-775),0,0)
                if not(ja)then
                else
                    Hb[Nb(-15440-5923)].CFrame=ja.CFrame*R
                end
                if Q then
                    Hb[-26813- -26815].CFrame=Q.CFrame*R
                end
                if g then
                    Hb[Nb(47558-28932)].CFrame=Lerp(Hb[8750+-8747].CFrame,g.CFrame*R,-14398- -14399)
                end
                if ua then
                    Hb[6871-6867].CFrame=Lerp(Hb[-0.00020537043692560455*-19477].CFrame,ua.CFrame*R,0.00033590863285186428*2977)
                end
            end
        end){[0.56750815227347673*27293]=-7534+7537,[-5253+-19247]=-0.00015499070055796651*-6452}
    end)
end)({[-32369+1897]=ea('p\239K\238',"\'\138"),[42731-25923]=0,[7116+-23991]=13582-13581,[9065-32289]=-13360.5- -13361,[185384178/-24054]=-15124- -15125,[321127170/-32718]=ea('\194S(\229\249\226P/\213\249','\144&F\182\156'),[-0.62881281172598646*29473]=ea('[\133x\158','\v\234'),[-1.9891646966115051*-15228]=-18592- -18594,[-9843- -30261]=0,[-31528+4932]=-59972/29986,[-0.48258233655579225*30515]=ea('\205\175m\139\142\156e\159\153','\237\238\4\249'),[-23503+4479]=ea('\129\205\162\214','\209\162'),[12573+15977]=0,[-0.2481058546311401*27585]=ea('ck\169u\137H.\186|\129','1\14\200\25\229'),[-422192506/22369]=30336+-30335,[21923+-22588]=0,[16576+-28193]=-25490/-25490,[-6027- -19678]=26015+-26014,[0.78061589878252569*-29323]=ea('\22\211\52\198','F\178'),[1.5493351994401678*-15719]=0,[-0.98186136903476573*23155]=5917+-5918,[20524+-28915]=ea('}\1C\3','-h'),[40049+-24848]=-14423+14424,[-120763200/13575]=-6081- -6082,[-2713-19360]=ea('^\130\131\231x\203\165\253a','\f\235\228\143'),[1936-893]=3240+-3238,[3828+5034]=-990- -1238,[-696935071/-29267]=-2452/-2452,[-2546+2314]=7739+-7612,[-48601+23098]=0,[-0.8921602486617165*-23164]=-2766.5- -2767,[-7584+-13360]=-29080+29207,[0.3686942978281561*23114]=0,[17372- -14732]=ea('Y\196\129\135\156y\199\134\183\156','\v\177\239\212\249')},...)
