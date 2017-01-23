--Forest Wolf
function c511001418.initial_effect(c)
	--equip
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetCode(EVENT_BATTLE_DESTROYING)
	e1:SetProperty(EFFECT_FLAG_DELAY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetOperation(c511001418.eqop)
	c:RegisterEffect(e1)
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e4:SetCode(EVENT_LEAVE_FIELD_P)
	e4:SetOperation(c511001418.eqcheck)
	c:RegisterEffect(e4)
	--Release equipped monsters
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_LEAVE_FIELD)
	e2:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e2:SetCondition(c511001418.damcon)
	e2:SetTarget(c511001418.damtg)
	e2:SetOperation(c511001418.damop)
	e2:SetLabelObject(e4)
	c:RegisterEffect(e2)
end
function c511001418.eqop(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_SZONE)<=0 then return end
	local c=e:GetHandler()
	local d=Duel.GetAttackTarget()
	if d==c then d=Duel.GetAttacker() end
	if not d or c:IsStatus(STATUS_BATTLE_DESTROYED) then return end
	if c:IsFaceup() and c:IsRelateToEffect(e) then 
		Duel.Equip(tp,d,c)
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_EQUIP_LIMIT)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		e1:SetValue(c511001418.eqlimit)
		d:RegisterEffect(e1)
	end
end
function c511001418.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511001418.eqcheck(e,tp,eg,ep,ev,re,r,rp)
	if e:GetLabelObject() then e:GetLabelObject():DeleteGroup() end
	local g=e:GetHandler():GetEquipGroup()
	g:KeepAlive()
	e:SetLabelObject(g)
end
function c511001418.damcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	return c:IsReason(REASON_DESTROY) and c:GetPreviousLocation()==LOCATION_MZONE
end
function c511001418.spfilter2(c,e,tp)
	return c:IsCanBeSpecialSummoned(e,0,tp,false,false)
end
function c511001418.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=e:GetLabelObject():GetLabelObject()
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,g,g:GetCount(),0,0)
end
function c511001418.damop(e,tp,eg,ep,ev,re,r,rp)
	local g=e:GetLabelObject():GetLabelObject()
	local ft=Duel.GetLocationCount(tp,LOCATION_MZONE)
	if ft>1 and Duel.IsPlayerAffectedByEffect(tp,59822133) then ft=1 end
	if g:GetCount()>ft then return end
	local tc=g:GetFirst()
	while tc do
		Duel.SpecialSummonStep(tc,0,tc:GetOwner(),tc:GetOwner(),false,false,POS_FACEUP)
		tc=g:GetNext()
	end
	Duel.SpecialSummonComplete()
end
