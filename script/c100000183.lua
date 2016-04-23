--マタタビ・タービン
function c100000183.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_EQUIP)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetProperty(EFFECT_FLAG_CARD_TARGET)
	e1:SetTarget(c100000183.target)
	e1:SetOperation(c100000183.operation)
	c:RegisterEffect(e1)
	--Equip limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_EQUIP_LIMIT)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE)
	e2:SetValue(c100000183.eqlimit)
	c:RegisterEffect(e2)
	--Atk up
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_EQUIP)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(1200)
	c:RegisterEffect(e3)
	--cannot attack
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_EQUIP)
	e4:SetCode(EFFECT_CANNOT_ATTACK)
	e4:SetCondition(c100000183.atcon)
	c:RegisterEffect(e4)	
	--cannot be battle target
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD)
	e5:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e5:SetRange(LOCATION_SZONE)
	e5:SetTargetRange(0,LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_SET_AVAILABLE)
	e5:SetCondition(c100000183.ocon1)
	e5:SetTarget(c100000183.tg)
	e5:SetValue(1)
	c:RegisterEffect(e5,tp)
end
function c100000183.tg(e,c)
	return c==Duel.GetAttackTarget()
end
function c100000183.eqlimit(e,c)
	return c:IsSetCard(0x305)
end
function c100000183.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x305)
end
function c100000183.target(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chkc then return chkc:IsLocation(LOCATION_MZONE) and c100000183.filter(chkc) end
	if chk==0 then return Duel.IsExistingTarget(c100000183.filter,tp,LOCATION_MZONE,0,1,nil) end
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_EQUIP)
	Duel.SelectTarget(tp,c100000183.filter,tp,LOCATION_MZONE,0,1,1,nil)
	Duel.SetOperationInfo(0,CATEGORY_EQUIP,e:GetHandler(),1,0,0)
end
function c100000183.operation(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local tc=Duel.GetFirstTarget()
	if c:IsRelateToEffect(e) and tc:IsRelateToEffect(e) and tc:IsFaceup() then
		Duel.Equip(tp,c,tc)
	end
end
function c100000183.atcon(e)
	local c=e:GetHandler()
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)>0
	and not c:GetEquipTarget():IsHasEffect(EFFECT_DIRECT_ATTACK)
end

function c100000183.ocon1(e)
	local c=e:GetHandler()
	return Duel.GetAttacker()==c:GetEquipTarget()
end
function c100000183.tg(e,c)
	return c:IsType(TYPE_MONSTER)
end