--Joyful Doom
function c511002093.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetCode(EVENT_SUMMON_SUCCESS)
	e1:SetCondition(c511002093.condition)
	e1:SetTarget(c511002093.target)
	e1:SetOperation(c511002093.activate)
	c:RegisterEffect(e1)
end
function c511002093.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return eg:GetCount()==1 and bit.band(tc:GetSummonType(),SUMMON_TYPE_ADVANCE)==SUMMON_TYPE_ADVANCE 
		and tc:GetSummonPlayer()~=tp
end
function c511002093.target(e,tp,eg,ep,ev,re,r,rp,chk)
	local tc=eg:GetFirst()
	local g=tc:GetMaterial()
	if chk==0 then return g:GetCount()>0 end
	local lp=g:GetSum(Card.GetPreviousAttackOnField)
	Duel.SetTargetCard(tc)
	Duel.SetTargetPlayer(tp)
	Duel.SetTargetParam(lp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,lp)
end
function c511002093.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsRelateToEffect(e) then
		local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
		Duel.Recover(p,d,REASON_EFFECT)
		if tc:IsCode(88071625) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetValue(-d)
			e1:SetReset(RESET_EVENT+0xfe0000)
			tc:RegisterEffect(e1)
		elseif tc:IsCode(47942531) or tc:IsCode(8794435) or tc:IsCode(6614221) or tc:GetOriginalCode()==110000010 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_ATTACK)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0xfe0000)
			tc:RegisterEffect(e1)
		elseif tc:GetOriginalCode()==51100236 then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE+EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetRange(LOCATION_MZONE)
			e1:SetValue(0)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		elseif tc:IsCode(23770284) then
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_UPDATE_ATTACK)
			e1:SetValue(-d/2)
			e1:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			tc:RegisterEffect(e1)
		end
	end
end
