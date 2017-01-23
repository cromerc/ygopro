-- Multiply (Anime)
-- scripted by: UnknownGuest
function c810000034.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_SPECIAL_SUMMON)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c810000034.target)
	e1:SetOperation(c810000034.activate)
	c:RegisterEffect(e1)
end
function c810000034.filter(c,e,tp)
	if c:IsFacedown() then return false end
	if c:IsCode(40640057) then
		return Duel.IsPlayerCanSpecialSummonMonster(tp,40703223,0,0x4011,c:GetAttack(),c:GetDefense(),1,RACE_FIEND,ATTRIBUTE_DARK) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
	elseif c:IsAttackBelow(500) then
		return Duel.IsPlayerCanSpecialSummonMonster(tp,c:GetOriginalCode(),0,c:GetType(),c:GetAttack(),c:GetDefense(),c:GetLevel(),c:GetRace(),c:GetAttribute()) 
			and Duel.GetLocationCount(tp,LOCATION_MZONE)>1 and not Duel.IsPlayerAffectedByEffect(tp,59822133)
	else return false 
	end
end
function c810000034.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c810000034.filter(chkc,e,tp) end
	if chk==0 then return Duel.IsExistingTarget(c810000034.filter,tp,LOCATION_MZONE,0,1,nil,e,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c810000034.filter,tp,LOCATION_MZONE,0,1,1,nil,e,tp)
	if g:GetFirst():IsCode(40640057) then
		local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,ft,0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,ft,0,0)
	else
		Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,2,0,0)
		Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,2,0,0)
	end
end
function c810000034.activate(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if not tc or tc:IsFacedown() or not tc:IsRelateToEffect(e) then return end
	if tc:IsCode(40640057) then
		if ft<=0 or not Duel.IsPlayerCanSpecialSummonMonster(tp,40703223,0,0x4011,tc:GetAttack(),tc:GetDefense(),1,RACE_FIEND,ATTRIBUTE_DARK) then return end
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
		for i=1,ft do
			local token=Duel.CreateToken(tp,40703223)
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetValue(tc:GetAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SET_BASE_DEFENSE)
			e2:SetValue(tc:GetDefense())
			token:RegisterEffect(e2)
			local e3=Effect.CreateEffect(e:GetHandler())
			e3:SetType(EFFECT_TYPE_SINGLE)
			e3:SetCode(EFFECT_UNRELEASABLE_SUM)
			e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e3:SetValue(1)
			e3:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e3,true)
		end
		Duel.SpecialSummonComplete()
	else
		if Duel.IsPlayerAffectedByEffect(tp,59822133) then return end
		if ft<=1 
			or not Duel.IsPlayerCanSpecialSummonMonster(tp,tc:GetOriginalCode(),0,0x4011,tc:GetAttack(),tc:GetDefense(),tc:GetLevel(),
			tc:GetRace(),tc:GetAttribute()) then return end
		for i=1,2 do
			local token=Duel.CreateToken(tp,tc:GetOriginalCode())
			Duel.SpecialSummonStep(token,0,tp,tp,false,false,tc:GetPosition())
			local e1=Effect.CreateEffect(e:GetHandler())
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetCode(EFFECT_SET_BASE_ATTACK)
			e1:SetValue(tc:GetAttack())
			e1:SetReset(RESET_EVENT+0x1fe0000)
			token:RegisterEffect(e1)
			local e2=e1:Clone()
			e2:SetCode(EFFECT_SET_BASE_DEFENSE)
			e2:SetValue(tc:GetDefense())
			token:RegisterEffect(e2)
			local e3=e1:Clone()
			e3:SetCode(EFFECT_CHANGE_LEVEL)
			e3:SetValue(tc:GetLevel())
			token:RegisterEffect(e3)
			local e4=e1:Clone()
			e4:SetCode(EFFECT_CHANGE_RACE)
			e4:SetValue(tc:GetRace())
			token:RegisterEffect(e4)
			local e5=e1:Clone()
			e5:SetCode(EFFECT_CHANGE_ATTRIBUTE)
			e5:SetValue(tc:GetAttribute())
			token:RegisterEffect(e5)
			local e6=Effect.CreateEffect(e:GetHandler())
			e6:SetType(EFFECT_TYPE_SINGLE)
			e6:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
			e6:SetReset(RESET_EVENT+0x1fe0000)
			e6:SetCode(EFFECT_CHANGE_CODE)
			e6:SetValue(tc:GetOriginalCode())
			token:RegisterEffect(e6)
		end
		Duel.SpecialSummonComplete()
	end
end
