--スフィア・フィールド
function c100000186.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--XYZ
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100000186,0))
	e2:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTarget(c100000186.target)
	e2:SetOperation(c100000186.operation)
	c:RegisterEffect(e2)
	--activation
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)	
	e4:SetProperty(EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_PLAYER_TARGET)
	e4:SetCode(EFFECT_CANNOT_ACTIVATE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetTargetRange(1,1)
	e4:SetValue(c100000186.aclimit)
	Duel.RegisterEffect(e4,tp)	
	--unaffectable
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e6:SetRange(LOCATION_SZONE)
	e6:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e6:SetValue(1)
	c:RegisterEffect(e6)
	--cannot set
	local e7=Effect.CreateEffect(c)
	e7:SetType(EFFECT_TYPE_FIELD)
	e7:SetCode(EFFECT_CANNOT_SSET)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET+EFFECT_FLAG_UNCOPYABLE+EFFECT_FLAG_CANNOT_DISABLE)
	e7:SetRange(LOCATION_SZONE)
	e7:SetTargetRange(1,1)
	e7:SetTarget(c100000186.aclimit2)
	c:RegisterEffect(e7)
	--
	local eb=Effect.CreateEffect(c)
	eb:SetType(EFFECT_TYPE_FIELD)
	eb:SetCode(EFFECT_CANNOT_TO_DECK)
	eb:SetRange(LOCATION_SZONE)
	eb:SetTargetRange(LOCATION_SZONE,0)
	eb:SetTarget(c100000186.tgn)
	c:RegisterEffect(eb)
	local ec=eb:Clone()
	ec:SetCode(EFFECT_CANNOT_TO_HAND)
	c:RegisterEffect(ec)
	local ed=eb:Clone()
	ed:SetCode(EFFECT_CANNOT_TO_GRAVE)
	c:RegisterEffect(ed)
	local ee=eb:Clone()
	ee:SetCode(EFFECT_CANNOT_REMOVE)
	c:RegisterEffect(ee)
end
function c100000186.filter(c,e)
	return c:IsType(TYPE_MONSTER) and not c:IsImmuneToEffect(e)
end
function c100000186.lvfilter(c,lv)
	return c:GetLevel()==lv
end
function c100000186.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
		local g1=Duel.GetMatchingGroup(c100000186.filter,tp,LOCATION_HAND,0,nil,e)
		local g2=Duel.GetMatchingGroup(c100000186.filter,tp,LOCATION_HAND,0,nil,e)
		local gg=g1:GetFirst()
		local lv=0
		local mg1=Group.CreateGroup()
		local mg2=nil
		while gg do
			lv=gg:GetLevel()
			mg2=g2:Filter(c100000186.lvfilter,gg,lv)
			if mg2:GetCount()>0 then
				mg1:Merge(mg2)
				mg1:AddCard(gg)
			end		
			gg=g1:GetNext()
		end
		if mg1:GetCount()>1 and Duel.IsExistingMatchingCard(c100000186.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) then
		return true
		else
		return false
		end
	end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000186.xyzfilter(c,e,tp)
	return c:IsSetCard(0x48) and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000186.operation(e,tp,eg,ep,ev,re,r,rp)
	local chkf=Duel.GetLocationCount(tp,LOCATION_MZONE)>0 and PLAYER_NONE or tp
	if not e:GetHandler():IsRelateToEffect(e) then return end
	local g1=Duel.GetMatchingGroup(c100000186.filter,tp,LOCATION_HAND,0,nil,e)
	local g2=Duel.GetMatchingGroup(c100000186.filter,tp,LOCATION_HAND,0,nil,e)
	local gg=g1:GetFirst()
	local lv=0
	local mg1=Group.CreateGroup()
	local mg2=nil
	while gg do
		lv=gg:GetLevel()
		mg2=g2:Filter(c100000186.lvfilter,gg,lv)
		if mg2:GetCount()>0 then
			mg1:Merge(mg2)
			mg1:AddCard(gg)
		end		
		gg=g1:GetNext()
	end
	if mg1:GetCount()>1 and Duel.IsExistingMatchingCard(c100000186.xyzfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp) then
		local tg1=mg1:Select(tp,1,1,nil):GetFirst()			
		local tg2=mg1:FilterSelect(tp,c100000186.lvfilter,1,1,tg1,tg1:GetLevel())
		tg2:AddCard(tg1)			
		if tg2:GetCount()<2 then return end
		local xyzg=Duel.GetMatchingGroup(c100000186.xyzfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
		if xyzg:GetCount()>0 then
			Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
			local xyz=xyzg:RandomSelect(tp,1):GetFirst()	
			if Duel.SpecialSummonStep(xyz,0,tp,tp,false,false,POS_FACEUP) then
				--destroy
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)				
				e1:SetRange(LOCATION_MZONE)
				e1:SetCode(EFFECT_SELF_DESTROY)
				e1:SetCondition(c100000186.descon)
				e1:SetReset(RESET_EVENT+0xff0000)
				xyz:RegisterEffect(e1)
				Duel.Overlay(xyz,tg2)
				Duel.SpecialSummonComplete()	
			end				
		end		
	end	
end
function c100000186.descon(e)
	return e:GetHandler():GetOverlayCount()==0 and e:GetHandler():IsDestructable() and Duel.GetCurrentChain()==0
end
function c100000186.aclimit(e,re)
	return re:IsHasType(EFFECT_TYPE_ACTIVATE) and re:IsActiveType(TYPE_SPELL) and re:GetHandler():IsType(TYPE_FIELD)
end
function c100000186.aclimit2(e,c)
	return c:IsType(TYPE_FIELD)
end
function c100000186.tgn(e,c)
	return c==e:GetHandler()
end