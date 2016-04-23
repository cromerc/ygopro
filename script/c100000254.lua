--レベルの絆
function c100000254.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_DRAW)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	e1:SetTarget(c100000254.target)
	e1:SetOperation(c100000254.activate)
	c:RegisterEffect(e1)
end
function c100000254.filter(c,e,tp)
	local code=c:GetCode()
	return c:IsSetCard(0x41) and c:IsAbleToRemove()
	 and Duel.IsExistingMatchingCard(Card.IsCode,tp,LOCATION_GRAVE,0,1,c,code)
	 and Duel.IsExistingMatchingCard(c100000254.filter2,tp,LOCATION_DECK,0,1,c,code,e,tp)
end
function c100000254.filter2(c,code,e,tp)
	return c:GetCode()==code and c:IsCanBeSpecialSummoned(e,0,tp,true,false)
end
function c100000254.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsPlayerCanDraw(1-tp,2) and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	 and Duel.IsExistingMatchingCard(c100000254.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(2)
	Duel.SetOperationInfo(0,CATEGORY_DRAW,nil,0,1-tp,2)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_GRAVE)
end
function c100000254.activate(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.BreakEffect()
	Duel.Draw(p,d,REASON_EFFECT)
	local dg=Duel.GetMatchingGroup(c100000254.filter,tp,LOCATION_GRAVE,0,nil,e,tp)	
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<=0 and dg:GetCount()<1 then return end
	local c=e:GetHandler()	
	local tg=dg:GetFirst()
	local teg=Group.CreateGroup()
	while tg do
		if not teg:IsExists(Card.IsCode,1,nil,tg:GetCode()) then
			teg:AddCard(tg)		
		end
		tg=dg:GetNext()
	end	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_REMOVE)
	local des=teg:Select(tp,1,1,nil)
	local code=des:GetFirst():GetCode()
	local sdg=dg:Filter(Card.IsCode,des:GetFirst(),code):GetFirst()
	des:AddCard(sdg)	
	Duel.Remove(des,POS_FACEUP,REASON_EFFECT)	
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tc=Duel.GetMatchingGroup(c100000254.filter2,tp,LOCATION_DECK,0,nil,code,e,tp):GetFirst()
	if tc and Duel.SpecialSummonStep(tc,0,tp,tp,true,false,POS_FACEUP) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e1,true)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_DISABLE_EFFECT)
		e2:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e2,true)
		local e3=Effect.CreateEffect(c)
		e3:SetType(EFFECT_TYPE_SINGLE)
		e3:SetCode(EFFECT_CANNOT_ATTACK)
		e3:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
		e3:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+RESET_END)
		tc:RegisterEffect(e3,true)
		Duel.SpecialSummonComplete()
	end
end