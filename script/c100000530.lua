--集いし願い
function c100000530.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c100000530.target)
	e1:SetOperation(c100000530.operation)
	c:RegisterEffect(e1)
end
function c100000530.vfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_DRAGON)
end
function c100000530.sfilter(c,e,tp)
	return c:GetCode()==44508094 and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c100000530.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c100000530.filter1(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c100000530.sfilter,tp,LOCATION_EXTRA,0,1,nil,e,tp)
		and Duel.GetMatchingGroup(c100000530.vfilter,tp,LOCATION_GRAVE,0,nil):GetCount()>4 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c100000530.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if not c:IsRelateToEffect(e) then return end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local tg=Duel.GetFirstMatchingCard(c100000530.sfilter,tp,LOCATION_EXTRA,0,nil,e,tp)
	if c:IsRelateToEffect(e)  
	and Duel.SpecialSummonStep(tg,0,tp,tp,false,false,POS_FACEUP) then
		c:SetCardTarget(tg)
		Duel.Equip(tp,c,tg)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_EQUIP)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(c100000530.val)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
		--Equip limit
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetCode(EFFECT_EQUIP_LIMIT)
		e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e2:SetValue(c100000530.eqlimit)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
		--chain attack
		local e3=Effect.CreateEffect(c)
		e3:SetDescription(aux.Stringid(100000530,0))
		e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e3:SetRange(LOCATION_SZONE)
		e3:SetCode(EVENT_BATTLE_DESTROYING)
		e3:SetCondition(c100000530.atcon)
		e3:SetCost(c100000530.cost)
		e3:SetOperation(c100000530.atop)
		e3:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e3)
		local e4=Effect.CreateEffect(c)
		e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e4:SetRange(LOCATION_MZONE)
		e4:SetCode(EVENT_PHASE+PHASE_END)
		e4:SetOperation(c100000530.desop)
		e4:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		e4:SetCountLimit(1)
		tg:RegisterEffect(e4)
		Duel.SpecialSummonComplete()
	end
end
function c100000530.val(e,c)
	local g=Duel.GetMatchingGroup(c100000530.vfilter,c:GetControler(),LOCATION_GRAVE,0,c)
	return g:GetSum(Card.GetBaseAttack)
end
function c100000530.eqlimit(e,c)
	return c:GetCode()==44508094
end
function c100000530.sendfilter(c)
	return c:IsType(TYPE_SYNCHRO) and c:IsRace(RACE_DRAGON) and c:IsAbleToExtra()
end
function c100000530.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100000530.sendfilter,tp,LOCATION_GRAVE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TODECK)
	local g=Duel.SelectMatchingCard(tp,c100000530.sendfilter,tp,LOCATION_GRAVE,0,1,1,nil)
	Duel.SendtoDeck(g,nil,1,REASON_COST)
end
function c100000530.atcon(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetEquipTarget()
	if not eg:IsContains(ec) then return false end
	local bc=ec:GetBattleTarget()
	return bc:IsReason(REASON_BATTLE)
end
function c100000530.atop(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChainAttack()
end
function c100000530.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Remove(e:GetHandler(),POS_FACEUP,REASON_EFFECT)
end