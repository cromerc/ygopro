--QB解谜
Debug.SetAIName("高性能电子头脑")
Debug.ReloadFieldBegin(DUEL_ATTACK_FIRST_TURN+DUEL_SIMPLE_AI)
Debug.SetPlayerInfo(0,100,0,0)
Debug.SetPlayerInfo(1,3400,0,0)
--手牌1
--墓地1
--后场1  
--卡组1  
--怪区1
Debug.AddCard(89631139,1,1,LOCATION_MZONE,1,POS_FACEUP_ATTACK) --青眼白龙
Debug.AddCard(23995346,1,1,LOCATION_MZONE,2,POS_FACEUP_ATTACK) --青眼究极龙

--怪区0   
--卡组0
Debug.AddCard(47297616,0,0,LOCATION_DECK,0,POS_FACEDOWN)--光与暗之龙
Debug.AddCard(03954901,0,0,LOCATION_DECK,0,POS_FACEDOWN)--闪耀巨龙
Debug.AddCard(89631139,0,0,LOCATION_DECK,0,POS_FACEDOWN)--青眼白龙
Debug.AddCard(77625948,0,0,LOCATION_DECK,0,POS_FACEDOWN)--电子暗黑翼刃
Debug.AddCard(47754278,0,0,LOCATION_DECK,0,POS_FACEDOWN)--地狱龙
Debug.AddCard(41230939,0,0,LOCATION_DECK,0,POS_FACEDOWN)--电子暗黑魔角
Debug.AddCard(03019642,0,0,LOCATION_DECK,0,POS_FACEDOWN)--电子暗黑龙骨
Debug.AddCard(59464593,0,0,LOCATION_DECK,0,POS_FACEDOWN)--武装龙 LV10
--后场0  
Debug.AddCard(97077563,0,0,LOCATION_SZONE,2,POS_FACEDOWN)--活死人的呼声
--墓地0
--手牌0 
Debug.AddCard(85087012,0,0,LOCATION_HAND,0,POS_FACEDOWN)--卡片炮击士
Debug.AddCard(80033124,0,0,LOCATION_HAND,0,POS_FACEDOWN)--电子暗黑冲击！
Debug.AddCard(05318639,0,0,LOCATION_HAND,0,POS_FACEDOWN)--旋风
Debug.AddCard(77565204,0,0,LOCATION_HAND,0,POS_FACEDOWN)--未来融合
--额外0
Debug.AddCard(40418351,0,0,LOCATION_DECK,0,POS_FACEDOWN)--铠黑龙-电子暗黑龙
Debug.AddCard(99267150,0,0,LOCATION_DECK,0,POS_FACEDOWN)--五神龙
--除外

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
--POS_FACEDOWN   里侧
--POS_FACEUP     表侧
--POS_FACEUP_DEFENCE    表侧防守
--POS_FACEUP_ATTACK     表侧攻击
--Debug.PreEquip(e1,c1)  绑定e1和C1