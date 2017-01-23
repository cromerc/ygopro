--Synchronic Ability
--scripted by: UnknownGuest
function c810000064.initial_effect(c)
	-- Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c810000064.target)
	e1:SetOperation(c810000064.operation)
	c:RegisterEffect(e1)
	-- gain effects
	--local e2=Effect.CreateEffect(c)
	--e2:SetType(EFFECT_TYPE_EQUIP+EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	--e2:SetType(EFFECT_TYPE_EQUIP)
	--e2:SetCode(EVENT_ADJUST)
	--e2:SetRange(LOCATION_SZONE)
	--e2:SetOperation(c810000064.gainop)
	--c:RegisterEffect(e2)
	-- Equip limit
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_EQUIP_LIMIT)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e3:SetValue(1)
	c:RegisterEffect(e3)
end
function c810000064.filter(c)
	return c:IsFaceup()
end
function c810000064.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:GetLocation()==LOCATION_MZONE and c810000064.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c810000064.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c810000064.filter,tp,LOCATION_MZONE,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c810000064.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
		local e1=Effect.CreateEffect(tc)
		e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		e1:SetCode(EVENT_ADJUST)
		e1:SetRange(LOCATION_MZONE)
		e1:SetOperation(c810000064.eqop)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
function c810000064.gainop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=c:GetEquipTarget()
	local e1=Effect.CreateEffect(tc)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetOperation(c810000064.eqop)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	tc:RegisterEffect(e1)
end
function c810000064.eqfilter(c,race)
	return c:IsType(TYPE_MONSTER) and c:IsRace(race)
end
function c810000064.eqop(e,tp,eg,ep,ev,re,r,rp)
	--local c=e:GetHandler():GetEquipTarget()
	local c=e:GetHandler()
	local eqt=c:GetRace()
	local wg=Duel.GetMatchingGroup(c810000064.eqfilter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,nil,eqt)
	local wbc=wg:GetFirst()
	while wbc do
		local code=wbc:GetOriginalCode()
		if c:IsFaceup() and c:GetFlagEffect(code)==0 then
		c:CopyEffect(code,RESET_EVENT+0x1fe0000+EVENT_CHAINING, 1)
		c:RegisterFlagEffect(code,RESET_EVENT+0x1fe0000+EVENT_CHAINING,0,1)
		end
		wbc=wg:GetNext()
	end
end
