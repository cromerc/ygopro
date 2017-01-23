--Traitor Fog
function c511000773.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetTarget(c511000773.target)
	e1:SetOperation(c511000773.activate)
	c:RegisterEffect(e1)
	--return
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetOperation(c511000773.checkop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511000773.retop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_CONTROL_CHANGED)
	e4:SetCondition(c511000773.descon)
	e4:SetOperation(c511000773.desop)
	c:RegisterEffect(e4)
end
function c511000773.filter(c,tp)
	return c:IsFaceup() and c:GetControler()~=tp
		and c:IsControlerCanBeChanged()
end
function c511000773.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return eg:IsExists(c511000773.filter,1,nil,tp) end
	Duel.SetTargetCard(eg)
	local g=eg:Filter(c511000773.filter,nil,tp)
	Duel.SetOperationInfo(0,CATEGORY_CONTROL,g,g:GetCount(),0,0)
end
function c511000773.filter2(c,e,tp)
	return c:IsFaceup() and c:GetControler()~=tp
		and c:IsRelateToEffect(e) and c:IsControlerCanBeChanged()
end
function c511000773.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=eg:Filter(c511000773.filter2,nil,e,tp)
	local tc=g:GetFirst()
	if not tc then return end
	if g:GetCount()>1 then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_CONTROL)
		tc=g:Select(tp,1,1,nil):GetFirst()
	end
	Duel.GetControl(tc,tp)
	c:SetCardTarget(tc)
end
function c511000773.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDisabled() then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c511000773.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then return end
	local tc=e:GetHandler():GetFirstCardTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		Duel.GetControl(tc,1-tp)
	end
end
function c511000773.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetFirstCardTarget()
	return tc and eg:IsContains(tc)
end
function c511000773.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
