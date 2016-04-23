---インフェルノイド・ティエラ
function c5632.initial_effect(c)
	if c.material_count==nil then
		local code=c:GetOriginalCode()
		local mt=_G["c" .. code]
		mt.material_count=2
		mt.material={14799437,23440231}
	end
	c:EnableReviveLimit()
	local f1=Effect.CreateEffect(c)
	f1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	f1:SetType(EFFECT_TYPE_SINGLE)
	f1:SetCode(EFFECT_FUSION_MATERIAL)
	f1:SetCondition(c5632.fuscon)
	f1:SetOperation(c5632.fusop)
	c:RegisterEffect(f1)
	--
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(5632,0))
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCategory(CATEGORY_TOGRAVE)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c5632.condition)
	e1:SetTarget(c5632.target)
	e1:SetOperation(c5632.operation)
	c:RegisterEffect(e1)
end
function c5632.fumfilter(c,g1,ct1,g2,ct2,g3,ct3)
	local flag1=true
	local flag2=true
	local flag3=true
	if ct1>0 then flag1=g1:IsExists(aux.TRUE,ct1,c) end
	if ct2>0 then flag2=g2:IsExists(aux.TRUE,ct2,c) end
	if ct3>0 then flag3=g3:IsExists(aux.TRUE,ct3,c) end
	return flag1 and flag2 and flag3
end
function c5632.fumfilter1(c)
	return c:IsCanBeFusionMaterial()
	and (c:IsCode(14799437) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE))
end
function c5632.fumfilter2(c)
	return c:IsCanBeFusionMaterial()
	and (c:IsCode(23440231) or c:IsHasEffect(EFFECT_FUSION_SUBSTITUTE))
end
function c5632.fumfilter3(c)
	return c:IsCanBeFusionMaterial()
	and c:IsSetCard(0xbb)
end
function c5632.fuscon(e,g,gc,chkf)
	if g==nil then return true end
	local flag=false local flag1=false local flag2=false local flag3=false
	if gc then g:AddCard(gc) end
	local g1=g:Filter(c5632.fumfilter1,nil)
	local g2=g:Filter(c5632.fumfilter2,nil)
	local g3=g:Filter(c5632.fumfilter3,nil)
	local ct1=1 local ct2=1 local ct3=1
	local fg1=g1:Filter(c5632.fumfilter,nil,g1,ct1-1,g2,ct2,g3,ct3)
	local fg2=g2:Filter(c5632.fumfilter,nil,g1,ct1,g2,ct2-1,g3,ct3)
	local fg3=g3:Filter(c5632.fumfilter,nil,g1,ct1,g2,ct2,g3,ct3-1)
	local fg=Group.CreateGroup()
	fg:Merge(fg1)
	fg:Merge(fg2)
	fg:Merge(fg3)
	if gc then
		if c5632.fumfilter1(gc) and fg2:GetCount()>0 and fg3:GetCount()>0 then
			flag1=true
			if chkf~=PLAYER_NONE then
				fg:Sub(fg1)
				flag1=flag1 and fg:IsExists(aux.FConditionCheckF,1,nil,chkf)
				fg:Merge(fg1)
			end
		end
		if c5632.fumfilter2(gc) and fg1:GetCount()>0 and fg3:GetCount()>0 then
			flag2=true
			if chkf~=PLAYER_NONE then
				fg:Sub(fg2)
				flag2=flag2 and fg:IsExists(aux.FConditionCheckF,1,nil,chkf)
				fg:Merge(fg2)
			end
		end
		if c5632.fumfilter3(gc) and fg1:GetCount()>0 and fg2:GetCount()>0 then
			flag3=true
			if chkf~=PLAYER_NONE then
				fg:Sub(fg3)
				flag3=flag3 and fg:IsExists(aux.FConditionCheckF,1,nil,chkf)
				fg:Merge(fg3)
			end
		end
	else
		flag=fg1:GetCount()>0 and fg2:GetCount()>0 and fg3:GetCount()>0
		if chkf~=PLAYER_NONE then flag=flag and fg:IsExists(aux.FConditionCheckF,1,nil,chkf) end
	end
	return flag or flag1 or flag2 or flag3 or flag4
end
function c5632.fusop(e,tp,eg,ep,ev,re,r,rp,gc,chkf)
	local g=eg:Clone()
	if gc then g:AddCard(gc) end
	local g1=g:Filter(c5632.fumfilter1,nil)
	local g2=g:Filter(c5632.fumfilter2,nil)
	local g3=g:Filter(c5632.fumfilter3,nil)
	local ct1=1 local ct2=1 local ct3=1
	local fg1=g1:Filter(c5632.fumfilter,nil,g1,ct1-1,g2,ct2,g3,ct3)
	local fg2=g2:Filter(c5632.fumfilter,nil,g1,ct1,g2,ct2-1,g3,ct3)
	local fg3=g3:Filter(c5632.fumfilter,nil,g1,ct1,g2,ct2,g3,ct3-1)
	local fg=Group.CreateGroup()
	fg:Merge(fg1)
	fg:Merge(fg2)
	fg:Merge(fg3)
	--
	local mg=Group.CreateGroup()
	--
	fg1:Sub(mg)
	if chkf~=PLAYER_NONE then
		local fgs=fg:Clone()
		fgs:Sub(fg1)
		if not fgs:IsExists(aux.FConditionCheckF,1,nil,chkf) then
			fg1=fg1:Filter(aux.FConditionCheckF,nil,chkf)
		end
	end
	if gc then
		if not c5632.fumfilter2(gc)
		and not c5632.fumfilter3(gc)
		then
			fg1=nil
			fg1:AddCard(gc)
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,511)
	local tg=fg1:Select(tp,1,1,nil)
	mg:Merge(tg)
	--
	fg2:Sub(mg)
	if chkf~=PLAYER_NONE then
		local fgs=fg:Clone()
		fgs:Sub(fg2)
		if not fgs:IsExists(aux.FConditionCheckF,1,nil,chkf) then
			fg2=fg2:Filter(aux.FConditionCheckF,nil,chkf)
		end
	end
	if gc then
		if not c5632.fumfilter1(gc)
		and not c5632.fumfilter3(gc)
		then
			fg2=nil
			fg2:AddCard(gc)
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,511)
	local tg=fg2:Select(tp,1,1,nil)
	mg:Merge(tg)
	--
	fg3:Sub(mg)
	if chkf~=PLAYER_NONE then
		local fgs=fg:Clone()
		fgs:Sub(fg3)
		if not fgs:IsExists(aux.FConditionCheckF,1,nil,chkf) then
			fg3=fg3:Filter(aux.FConditionCheckF,nil,chkf)
		end
	end
	if gc then
		if not c5632.fumfilter1(gc)
		and not c5632.fumfilter2(gc)
		then
			fg3=nil
			fg3:AddCard(gc)
		end
	end
	Duel.Hint(HINT_SELECTMSG,tp,511)
	local tg=fg3:Select(tp,1,1,nil)
	mg:Merge(tg)
	--
	if Duel.SelectYesNo(tp,aux.Stringid(5632,0)) then
		fg3:Sub(mg)
		local fg3s=fg3:Filter(Card.IsLocation,nil,LOCATION_DECK)
		fg3:Sub(fg3s)
		if fg3s:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(5632,1)) then
			Duel.Hint(HINT_SELECTMSG,tp,511)
			local tg=fg3s:Select(tp,1,6-mg:Filter(Card.IsLocation,nil,LOCATION_DECK):GetCount(),nil)
			mg:Merge(tg)
		end
		if fg3:GetCount()>0 and Duel.SelectYesNo(tp,aux.Stringid(5632,2)) then
			Duel.Hint(HINT_SELECTMSG,tp,511)
			local tg=fg3:Select(tp,1,60,nil)
			mg:Merge(tg)
		end
	end
	--
	Duel.SetFusionMaterial(mg)
	--
end
function c5632.condition(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	return bit.band(c:GetSummonType(),SUMMON_TYPE_FUSION)==SUMMON_TYPE_FUSION
end
function c5632.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local mg=c:GetMaterial()
	local ct=0
	if mg:GetCount()>0 then
		ct=mg:GetClassCount(Card.GetOriginalCode)
	end
	local flag1=ct>=3
	and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_EXTRA,0,3,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,3,nil)
	local flag2=ct>=5
	and Duel.GetDecktopGroup(tp,3):IsExists(Card.IsAbleToGrave,3,nil)
	and Duel.GetDecktopGroup(1-tp,3):IsExists(Card.IsAbleToGrave,3,nil)
	local flag3=ct>=8 
	and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_REMOVED,0,3,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_REMOVED,3,nil)
	local flag4=ct>=10 
	and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,LOCATION_HAND,0,1,nil)
	and Duel.IsExistingMatchingCard(Card.IsAbleToGrave,tp,0,LOCATION_HAND,1,nil)
	if chk==0 then return flag1 or flag2 or flag3 or flag4 end
	local ft=0
	local loc=0
	if flag1 then
		loc=loc+LOCATION_EXTRA
		ft=ft+6
	end
	if flag2 then
		loc=loc+LOCATION_DECK
		ft=ft+6
	end
	if flag3 then
		loc=loc+LOCATION_REMOVED
		ft=ft+6
	end
	if flag4 then
		loc=loc+LOCATION_HAND
		ft=ft+Duel.GetFieldGroupCount(tp,LOCATION_HAND,LOCATION_HAND)
	end
	local g=Group.CreateGroup()
	g:Merge(Duel.GetDecktopGroup(tp,3))
	g:Merge(Duel.GetDecktopGroup(1-tp,3))
	Duel.SetOperationInfo(tp,CATEGORY_TOGRAVE,g,ft,PLAYER_ALL,loc)
end	
function c5632.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tp=c:GetControler()
	local mg=c:GetMaterial()
	local ct=mg:GetClassCount(Card.GetOriginalCode)
	local g=Group.CreateGroup()
	--
	local exg1=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_EXTRA,0,nil)
	local exg2=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_EXTRA,nil)
	if ct>=3 and exg1:GetCount()>0 and exg2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,504)
		local extg1=exg1:Select(tp,3,3,nil)
		Duel.Hint(HINT_SELECTMSG,1-tp,504)
		local extg2=exg2:Select(1-tp,3,3,nil)
		extg1:Merge(extg2)
		Duel.SendtoGrave(extg1,REASON_EFFECT)
	end
	--
	local dg1=Duel.GetDecktopGroup(tp,3):Filter(Card.IsAbleToGrave,nil)
	local dg2=Duel.GetDecktopGroup(1-tp,3):Filter(Card.IsAbleToGrave,nil)
	if ct>=5 and dg1:GetCount()>0 and dg2:GetCount()>0 then
		dg1:Merge(dg2)
		Duel.SendtoGrave(dg1,REASON_EFFECT)
	end
	--
	local rmg1=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,LOCATION_REMOVED,0,nil)
	local rmg2=Duel.GetMatchingGroup(Card.IsAbleToGrave,tp,0,LOCATION_REMOVED,nil)
	if ct>=8 and rmg1:GetCount()>0 and rmg2:GetCount()>0 then
		Duel.Hint(HINT_SELECTMSG,tp,504)
		local rmtg1=rmg1:Select(tp,1,3,nil)
		Duel.Hint(HINT_SELECTMSG,1-tp,504)
		local rmtg2=rmg2:Select(1-tp,1,3,nil)
		rmtg1:Merge(rmtg2)
		Duel.SendtoGrave(rmtg1,REASON_EFFECT+REASON_RETURN)
	end
	--
	local hg=Duel.GetFieldGroup(tp,LOCATION_HAND,LOCATION_HAND):Filter(Card.IsAbleToGrave,nil)
	if ct>=10 and hg:GetCount()>0 then
		Duel.SendtoGrave(hg,REASON_EFFECT)
	end
end	
