--Ultra C
function c511001064.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_CONTROL)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c511001064.condition)
	e1:SetTarget(c511001064.target)
	e1:SetOperation(c511001064.activate)
	c:RegisterEffect(e1)
	--return
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetCode(EVENT_LEAVE_FIELD_P)
	e2:SetOperation(c511001064.checkop)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_SINGLE)
	e3:SetCode(EVENT_LEAVE_FIELD)
	e3:SetOperation(c511001064.retop)
	e3:SetLabelObject(e2)
	c:RegisterEffect(e3)
	--Destroy
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_CONTINUOUS+EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_CONTROL_CHANGED)
	e4:SetCondition(c511001064.descon)
	e4:SetOperation(c511001064.desop)
	c:RegisterEffect(e4)
end
function c511001064.condition(e,tp,eg,ep,ev,re,r,rp)
	local tc=eg:GetFirst()
	return tc:GetSummonType()==SUMMON_TYPE_XYZ and tc:IsControler(1-tp) and tc:IsCode(12533811)
end
function c511001064.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_MZONE)>0 
		and Duel.GetFieldGroupCount(tp,0,LOCATION_EXTRA)>0 end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,tp,LOCATION_EXTRA)
end
function c511001064.spfilter(c,e,tp)
	return c:IsType(TYPE_XYZ) and c:IsCanBeSpecialSummoned(e,SUMMON_TYPE_XYZ,tp,false,false)
end
function c511001064.eqlimit(e,c)
	return e:GetLabelObject()==c
end
function c511001064.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local sg=Duel.GetMatchingGroup(c511001064.spfilter,tp,0,LOCATION_EXTRA,nil,e,tp)
	if sg:GetCount()<=0 then
		local g=Duel.GetFieldGroup(tp,0,LOCATION_EXTRA)
		Duel.ConfirmCards(tp,g)
	else
		Duel.ConfirmCards(tp,sg)
		local g=sg:Select(tp,1,1,nil):GetFirst()
		if Duel.SpecialSummon(g,SUMMON_TYPE_XYZ,tp,tp,false,false,POS_FACEUP)==0 then return end
		g:CompleteProcedure()
		Duel.Equip(tp,c,g)
		--Add Equip limit
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511001064.eqlimit)
		e1:SetLabelObject(g)
		c:RegisterEffect(e1)
	end
end
function c511001064.checkop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsDisabled() then
		e:SetLabel(1)
	else e:SetLabel(0) end
end
function c511001064.retop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject():GetLabel()~=0 then return end
	local tc=e:GetHandler():GetEquipTarget()
	if tc and tc:IsLocation(LOCATION_MZONE) then
		if not Duel.GetControl(tc,1-tp) then
			if not tc:IsImmuneToEffect(e) and tc:IsAbleToChangeControler() then
				Duel.Destroy(tc,REASON_EFFECT)
			end
		end
	end
end
function c511001064.descon(e,tp,eg,ep,ev,re,r,rp)
	local tc=e:GetHandler():GetEquipTarget()
	return tc and eg:IsContains(tc)
end
function c511001064.desop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end
