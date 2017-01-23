--ワルキューレ・ブリュンヒルデ
function c100000538.initial_effect(c)
    --atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(c100000538.val)
	c:RegisterEffect(e1)
	--Destroy replace
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_DESTROY_REPLACE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTarget(c100000538.desreptg)
	c:RegisterEffect(e2)
end
function c100000538.filter(c)
	return (c:IsRace(RACE_DRAGON) or c:IsRace(RACE_WARRIOR)) and c:IsFaceup()
end
function c100000538.val(e,c)
	return Duel.GetMatchingGroupCount(c100000538.filter,0,LOCATION_MZONE,LOCATION_MZONE,nil)*300
end
function c100000538.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return c:IsReason(REASON_BATTLE) and c:IsFaceup() and c:GetDefense()>=1000 end
	if Duel.SelectYesNo(tp,aux.Stringid(40945356,0)) then
		local e2=Effect.CreateEffect(c)
		e2:SetType(EFFECT_TYPE_SINGLE)
		e2:SetProperty(EFFECT_FLAG_COPY_INHERIT)
		e2:SetReset(RESET_EVENT+0x1ff0000)
		e2:SetCode(EFFECT_UPDATE_DEFENSE)
		e2:SetValue(-1000)
		c:RegisterEffect(e2)
		return true
	else return false end
end
