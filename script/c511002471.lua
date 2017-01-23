--Endless Bond
function c511002471.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c511002471.target)
	e1:SetOperation(c511002471.operation)
	c:RegisterEffect(e1)
end
function c511002471.filter(c,e,tp)
	return c:IsSetCard(0x107f) and c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511002471.afilter(c)
	return c:IsSetCard(0x107f) and c:IsType(TYPE_MONSTER)
end
function c511002471.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_GRAVE) and chkc:IsControler(tp) and c511002471.filter(chkc,e,tp) end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingTarget(c511002471.filter,tp,LOCATION_GRAVE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_SPSUMMON)
	local g=Duel.SelectTarget(tp,c511002471.filter,tp,LOCATION_GRAVE,0,1,1,nil,e,tp)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,1,0,0)
end
function c511002471.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc and tc:IsRelateToEffect(e) then
		if Duel.SpecialSummon(tc,0,tp,tp,false,false,POS_FACEUP)==0 then return end
		c:SetCardTarget(tc)
		local g=Duel.GetMatchingGroup(c511002471.afilter,tp,LOCATION_GRAVE,0,nil)
		local atk=0
		local tg=g:GetFirst()
		while tg do
			atk=atk+tg:GetAttack()
			tg=g:GetNext()
		end
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
		e2:SetDescription(aux.Stringid(48447192,0))
		e2:SetCode(EVENT_BATTLE_DESTROYING)
		e2:SetRange(LOCATION_SZONE)
		e2:SetCondition(c511002471.con)
		e2:SetTarget(c511002471.tg)
		e2:SetOperation(c511002471.op)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e2)
	end
end
function c511002471.con(e,tp,eg,ep,ev,re,r,rp)
	local ec=e:GetHandler():GetCardTarget():GetFirst()
	return ec and eg:IsContains(ec)
end
function c511002471.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	local ec=e:GetHandler():GetCardTarget():GetFirst()
	if chk==0 then return ec:GetAttack()>=1000 end
	Duel.SetTargetCard(ec)
end
function c511002471.op(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-1000)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
		Duel.ChainAttack()
		local bc=tc:GetBattleTarget()
		if bc and bc:GetOwner()==tp and Duel.IsPlayerCanDraw(tp,1) and Duel.SelectYesNo(tp,aux.Stringid(41858121,0)) then
			Duel.BreakEffect()
			Duel.Draw(tp,1,REASON_EFFECT)
		end
	end
end
