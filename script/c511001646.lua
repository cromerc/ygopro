--相生の魔術師
function c511001646.initial_effect(c)
	--pendulum summon
	aux.EnablePendulumAttribute(c)
	--change lv
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_PZONE)
	e2:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e2:SetCountLimit(1)
	e2:SetTarget(c511001646.lvtg)
	e2:SetOperation(c511001646.lvop)
	c:RegisterEffect(e2)
	--atk
	local e6=Effect.CreateEffect(c)
	e6:SetCategory(CATEGORY_ATKCHANGE)
	e6:SetType(EFFECT_TYPE_IGNITION)
	e6:SetRange(LOCATION_MZONE)
	e6:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e6:SetCountLimit(1)
	e6:SetTarget(c511001646.atktg)
	e6:SetOperation(c511001646.atkop)
	c:RegisterEffect(e6)
end
function c511001646.filter(c,tp)
	if not c:IsFaceup() then return false end
	if c:GetLevel()>0 then
		return Duel.IsExistingMatchingCard(c511001646.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetLevel())
	elseif c:GetRank()>0 and c:IsHasEffect(511002096) then
		return Duel.IsExistingMatchingCard(c511001646.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,c,c:GetRank())
	end
	return false
end
function c511001646.lvfilter(c,lv)
	if c:GetLevel()>0 then
		return c:IsFaceup() and c:GetLevel()~=lv
	elseif c:GetRank()>0 and c:IsHasEffect(EFFECT_XYZ_LEVEL) then
		return c:IsFaceup() and c:GetRank()~=lv
	end
	return false
end
function c511001646.lvtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c511001646.filter(chkc,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511001646.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001646.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tp)
end
function c511001646.lvop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
		local g
		if tc:GetLevel()>0 then
			g=Duel.SelectMatchingCard(tp,c511001646.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tc:GetLevel())
		else
			g=Duel.SelectMatchingCard(tp,c511001646.lvfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,tc:GetRank())
		end
		local tc2=g:GetFirst()
		if tc2 then
			Duel.HintSelection(g)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			if tc:GetLevel()>0 then
				e1:SetCode(EFFECT_CHANGE_LEVEL)
			else
				e1:SetCode(EFFECT_CHANGE_RANK)
			end
			if tc2:GetLevel()>0 then
				e1:SetValue(tc2:GetLevel())
			else
				e1:SetValue(tc2:GetRank())
			end
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			tc:RegisterEffect(e1)
		end
	end
end
function c511001646.atkfilter(c,atk)
	return c:IsFaceup() and c:GetAttack()~=atk
end
function c511001646.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local c=e:GetHandler()
	local atk=c:GetAttack()
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and chkc~=c and c511001646.atkfilter(chkc,atk) end
	if chk==0 then return Duel.IsExistingTarget(c511001646.atkfilter,tp,LOCATION_MZONE,0,1,c,atk) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_TARGET)
	Duel.SelectTarget(tp,c511001646.atkfilter,tp,LOCATION_MZONE,0,1,1,c,atk)
end
function c511001646.atkop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	local atk=tc:GetAttack()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() and c:IsRelateToEffect(e) and c:IsFaceup() then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_SET_ATTACK_FINAL)
		e1:SetValue(atk)
		e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
		c:RegisterEffect(e1)
	end
end
