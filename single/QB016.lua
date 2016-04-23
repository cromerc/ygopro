--QB解谜
Debug.SetAIName("高性能电子头脑")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI)
Debug.SetPlayerInfo(0,2500,0,0)
Debug.SetPlayerInfo(1,20000,0,0)
--怪区0

--卡组0
Debug.AddCard(00102380,0,0,LOCATION_DECK,0,POS_FACEDOWN)--熔岩魔神
Debug.AddCard(93187568,0,0,LOCATION_DECK,0,POS_FACEDOWN)--魔法攻击士
--Debug.AddCard(64751286,0,0,LOCATION_DECK,0,POS_FACEDOWN)--月之女战士
--后场0 
Debug.AddCard(82324105,0,0,LOCATION_SZONE,0,POS_FACEDOWN)--对极限的冲动
Debug.AddCard(42956963,0,0,LOCATION_SZONE,1,POS_FACEDOWN)--梦魇恶魔群
Debug.AddCard(90263923,0,0,LOCATION_SZONE,2,POS_FACEDOWN)--闪光吸收
Debug.AddCard(10012614,0,0,LOCATION_SZONE,3,POS_FACEUP)--勇气的旗帜
Debug.AddCard(31550470,0,0,LOCATION_SZONE,4,POS_FACEDOWN)--暗次元解放

--手牌0
Debug.AddCard(15341821,0,0,LOCATION_HAND,0,POS_FACEUP)--蒲公英狮
Debug.AddCard(09391354,0,0,LOCATION_HAND,0,POS_FACEDOWN)--重力击龙
Debug.AddCard(45450218,0,0,LOCATION_HAND,0,POS_FACEUP)--正义盟军 致命武器
Debug.AddCard(10352095,0,0,LOCATION_HAND,0,POS_FACEDOWN)--幻惑之卷物
Debug.AddCard(98045062,0,0,LOCATION_HAND,0,POS_FACEDOWN)--敌人控制器
Debug.AddCard(01475311,0,0,LOCATION_HAND,0,POS_FACEDOWN)--暗之诱惑

Debug.ReloadFieldEnd()
Debug.ShowHint("Win in this turn!")
aux.BeginPuzzle()
--注释

--LOCATION_DECK  卡组
--LOCATION_SZONE  后场
--LOCATION_GRAVE   墓地
--LOCATION_HAND    手牌
--LOCATION_MZONE   怪区
--LOCATION_EXTRA  额外
--LOCATION_REMOVED  除外
--POS_FACEDOWN   里侧
--POS_FACEUP     表侧
--POS_FACEUP_DEFENCE    表侧防守
--POS_FACEUP_ATTACK     表侧攻击
--Debug.PreEquip(e1,c1)  绑定e1和C1