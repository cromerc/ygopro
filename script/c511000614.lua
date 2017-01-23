--D－HERO Bloo－D (Anime)
function c511000614.initial_effect(c)
	c:EnableReviveLimit()
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.FALSE)
	c:RegisterEffect(e1)
	--special summon
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(511000614,0))
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_SPSUMMON_PROC)
	e2:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e2:SetRange(LOCATION_HAND)
	e2:SetCondition(c511000614.spcon)
	e2:SetOperation(c511000614.spop)
	c:RegisterEffect(e2)
	--equip
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(511000614,1))
	e3:SetCategory(CATEGORY_EQUIP)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCountLimit(1)
	e3:SetCondition(c511000614.eqcon)
	e3:SetTarget(c511000614.eqtg)
	e3:SetOperation(c511000614.eqop)
	c:RegisterEffect(e3)
	--disable
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD)
	e4:SetRange(LOCATION_MZONE)
	e4:SetTargetRange(0,LOCATION_MZONE)
	e4:SetCode(EFFECT_DISABLE)
	e4:SetCondition(c511000614.condition)
	c:RegisterEffect(e4)
	local e5=Effect.CreateEffect(c)
    e5:SetType(EFFECT_TYPE_SINGLE)
    e5:SetCode(EFFECT_IMMUNE_EFFECT)
    e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
    e5:SetRange(LOCATION_MZONE)
    e5:SetCondition(c511000614.condition)
	e5:SetValue(c511000614.efilter)
    c:RegisterEffect(e5)
end
function c511000614.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-3
		and Duel.CheckReleaseGroup(c:GetControler(),nil,3,nil)
end
function c511000614.spop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectReleaseGroup(c:GetControler(),nil,3,3,nil)
	Duel.Release(g,REASON_COST)
end
function c511000614.eqcon(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local ec=e:GetLabelObject()
	return ec==nil or ec:GetFlagEffect(511000614)==0
end
function c511000614.eqtg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and chkc:IsControler(1-tp) and chkc:IsAbleToChangeControler() end
	if chk==0 then return Duel.GetLocationCount(tp,LOCATION_SZONE)>0
		and Duel.IsExistingTarget(Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	local g=Duel.SelectTarget(tp,Card.IsAbleToChangeControler,tp,0,LOCATION_MZONE,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,g,1,0,0)
end
function c511000614.eqlimit(e,c)
	return e:GetOwner()==c
end
function c511000614.eqop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) then
		if c:IsFaceup() and c:IsRelateToEffect(e) then
			local atk=tc:GetTextAttack()/2
			if tc:IsFacedown() then atk=0 end
			if atk<0 then atk=0 end
			if not Duel.Equip(tp,tc,c,false) then return end
			--Add Equip limit
			tc:RegisterFlagEffect(511000614,RESET_EVENT+0x1fe0000,0,0)
			e:SetLabelObject(tc)
			local e1=Effect.CreateEffect(c)
			e1:SetType(EFFECT_TYPE_SINGLE)
			e1:SetProperty(EFFECT_FLAG_COPY_INHERIT+EFFECT_FLAG_OWNER_RELATE)
			e1:SetCode(EFFECT_EQUIP_LIMIT)
			e1:SetReset(RESET_EVENT+0x1fe0000)
			e1:SetValue(c511000614.eqlimit)
			tc:RegisterEffect(e1)
			if atk>0 then
				local e2=Effect.CreateEffect(c)
				e2:SetType(EFFECT_TYPE_EQUIP)
				e2:SetProperty(EFFECT_FLAG_IGNORE_IMMUNE+EFFECT_FLAG_OWNER_RELATE)
				e2:SetCode(EFFECT_UPDATE_ATTACK)
				e2:SetReset(RESET_EVENT+0x1fe0000)
				e2:SetValue(atk)
				tc:RegisterEffect(e2)
			end
			if tc:IsFaceup() then
				local e3=Effect.CreateEffect(c)
				e3:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
				e3:SetCode(EVENT_ADJUST)
				e3:SetRange(LOCATION_SZONE)	
				e3:SetOperation(c511000614.operation)
				e3:SetReset(RESET_EVENT+0x1fe0000)
				tc:RegisterEffect(e3)
			end
		else Duel.SendtoGrave(tc,REASON_EFFECT) end
	end
end
function c511000614.condition(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetDecktopGroup(e:GetHandlerPlayer(),1)
	return g and g:GetFirst():GetCode()==100000270 and g:GetFirst():IsFaceup()
end
function c511000614.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local eq=e:GetHandler():GetEquipTarget()
	local code=c:GetOriginalCode()
	if eq:IsFaceup() and eq:GetFlagEffect(code)==0 then
		eq:CopyEffect(code,RESET_EVENT+0x1fe0000+EVENT_CHAINING,1)
		eq:RegisterFlagEffect(code,RESET_EVENT+0x1fe0000+EVENT_CHAINING,0,1) 	
	end	
end
function c511000614.efilter(e,te)
	return (te:IsActiveType(TYPE_SPELL) or te:IsActiveType(TYPE_TRAP)) and te:GetOwnerPlayer()~=e:GetHandlerPlayer()
end
