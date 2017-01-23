--Double Parasitic Rebirth
--fixed by MLD
function c511009345.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DEFCHANGE)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET+EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(TIMING_DAMAGE_STEP)
	e1:SetCondition(c511009345.condition)
	e1:SetTarget(c511009345.target)
	e1:SetOperation(c511009345.activate)
	c:RegisterEffect(e1)
end
function c511009345.condition(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetCurrentPhase()~=PHASE_DAMAGE or not Duel.IsDamageCalculated()
end
function c511009345.filter(c,ft1,ft2,tp)
	local p=c:GetControler()
	if c:IsFacedown() then return false end
	local g1=Duel.GetMatchingGroupCount(Card.IsCode,tp,LOCATION_GRAVE,0,nil,6205579)
	local g2=Duel.GetMatchingGroupCount(Card.IsCode,tp,0,LOCATION_GRAVE,nil,6205579)
	local ft=0
	if Duel.GetLocationCount(p,LOCATION_SZONE)<=1 then return false end
	if g1>1 and ft1>1 then return true end
	if g2>1 and ft2>1 then return true end
	if g1>0 and g2>0 and ft1>0 and ft2>0 then return true end
	return false
end
function c511009345.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local ft1=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_SZONE)
	if e:GetHandler():IsLocation(LOCATION_HAND) then ft1=ft1-1 end
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(tp) and c511009345.filter(chkc,ft1,ft2,tp) end
	if chk==0 then return Duel.IsExistingTarget(c511009345.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil,ft1,ft2,tp) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c511009345.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil,ft1,ft2,tp)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,nil,2,tp,LOCATION_GRAVE)
end
function c511009345.activate(e,tp,eg,ep,ev,re,r,rp)
	local ft1=Duel.GetLocationCount(tp,LOCATION_SZONE)
	local ft2=Duel.GetLocationCount(1-tp,LOCATION_SZONE)
	local tc=Duel.GetFirstTarget()
	if tc and tc:IsFaceup() and tc:IsRelateToEffect(e) and c511009345.filter(tc,ft1,ft2,tp) then
		local p=tc:GetControler()
		if Duel.GetLocationCount(p,LOCATION_SZONE)<=1 then return end
		local g1=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_GRAVE,0,nil,6205579)
		local g2=Duel.GetMatchingGroup(Card.IsCode,tp,0,LOCATION_GRAVE,nil,6205579)
		local chk1=g1:GetCount()>1 and ft1>1
		local chk2=g2:GetCount()>1 and ft2>1
		local chk3=g2:GetCount()>0 and ft2>0 and g1:GetCount()>0 and ft1>0
		local eqg
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12152769,2))
		if chk1 and chk2 and chk3 then
			g1:Merge(g2)
			eqg=g1:Select(tp,2,2,nil)
		elseif chk1 and not chk3 then
			eqg=g1:Select(tp,2,2,nil)
		elseif chk2 and not chk3 then
			eqg=g2:Select(tp,2,2,nil)
		else
			g1:Merge(g2)
			eqg=g1:Select(tp,1,1,nil)
			local tc=eqg:GetFirst()
			if tc:IsControler(tp) then ft1=ft1-1 else ft2=ft2-1 end
			if ft1<=0 then g1:Remove(Card.IsControler,nil,tp) end
			if ft2<=0 then g1:Remove(Card.IsControler,nil,1-tp) end
			Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(12152769,2))
			local sel=g1:Select(tp,1,1,tc)
			eqg:Merge(sel)
		end
		Duel.HintSelection(eqg)
		local eqc=eqg:GetFirst()
		while eqc do
			if Duel.Equip(eqc:GetControler(),eqc,tc) then
				local e1=Effect.CreateEffect(e:GetHandler())
				e1:SetType(EFFECT_TYPE_SINGLE)
				e1:SetProperty(EFFECT_FLAG_OWNER_RELATE)
				e1:SetCode(EFFECT_EQUIP_LIMIT)
				e1:SetReset(RESET_EVENT+0xfe0000)
				e1:SetValue(c511009345.eqlimit)
				e1:SetLabelObject(tc)
				eqc:RegisterEffect(e1)
				eqc:RegisterFlagEffect(511009345,RESET_EVENT+0xfe0000,0,0)
			end
			eqc=eqg:GetNext()
		end
		Duel.EquipComplete()
		local e2=Effect.CreateEffect(e:GetHandler())
		e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e2:SetCode(EVENT_ADJUST)
		e2:SetRange(LOCATION_MZONE)
		e2:SetOperation(c511009345.ctop)
		e2:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e2)
	end
end	
function c511009345.eqlimit(e,c)
	return c==e:GetLabelObject()
end
function c511009345.ctfilter(c,tp)
	return c:GetFlagEffect(511009345)>0 and c:GetControler()~=tp
end
function c511009345.ctop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local p=c:GetControler()
	local g=c:GetEquipGroup():Filter(c511009345.ctfilter,nil,p)
	local tc=g:GetFirst()
	while tc do
		Duel.MoveToField(tc,p,p,LOCATION_SZONE,POS_FACEUP,true)
		Duel.Equip(p,tc,c)
		tc=g:GetNext()
	end
	Duel.EquipComplete()
end
