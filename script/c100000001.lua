--手をつなぐ魔人
function c100000001.initial_effect(c)
	--target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,0)
	e1:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e1:SetTarget(c100000001.tglimit)
	e1:SetValue(1)
	c:RegisterEffect(e1)
	--defup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_DEFENCE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c100000001.operation)
	c:RegisterEffect(e2)
end
function c100000001.tglimit(e,c)
	return c~=e:GetHandler()
end
function c100000001.filte(c)
	return c:IsFaceup() and c:GetCode()~=100000001
end
function c100000001.filter(c)
	return c:IsPosition(POS_FACEUP_DEFENCE) and c:GetCode()~=100000001
end
function c100000001.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c100000001.filte(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000001.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_FACEUP)
	local g=Duel.SelectTarget(tp,c100000001.filter,tp,LOCATION_MZONE,0,1,1,nil)
end
function c100000001.operation(e,c)
	local ndef=0
	local ng=Duel.GetMatchingGroup(c100000001.filter,c:GetControler(),LOCATION_MZONE,0,c)
	local nbc=ng:GetFirst()
	while nbc do
		ndef=ndef+nbc:GetBaseDefence()
		nbc=ng:GetNext()
	end
	 return ndef
end