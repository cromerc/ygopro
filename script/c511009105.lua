--Performage Trapeze Force Witch
function c511009105.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsFusionSetCard,0xc6),2,true)
	--indes
	local e2=Effect.CreateEffect(c)
	e2:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetTarget(c511009105.target)
	e2:SetValue(1)
	c:RegisterEffect(e2)
	--cannot be target
	local e3=e2:Clone()
	e3:SetCode(EFFECT_CANNOT_BE_EFFECT_TARGET)
	e3:SetValue(aux.tgoval)
	c:RegisterEffect(e3)
	
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_CANNOT_BE_BATTLE_TARGET)
	e4:SetCondition(c511009105.atcon)
	e4:SetValue(1)
	c:RegisterEffect(e4)
	--atk
	local e5=Effect.CreateEffect(c)
	e5:SetCategory(CATEGORY_ATKCHANGE)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e5:SetCode(EVENT_BATTLE_START)
	e5:SetRange(LOCATION_MZONE)
	e5:SetProperty(EFFECT_FLAG_CARD_TARGET)

	e5:SetCondition(c511009105.atkcon)
	e5:SetTarget(c511009105.atktg)
	e5:SetOperation(c511009105.atkop)
	c:RegisterEffect(e5)
end
function c511009105.target(e,c)
	return c:IsSetCard(0xc6)
end
function c511009105.atfilter(c)
	return c:IsFaceup() and c:IsSetCard(0xc6)
end
function c511009105.atcon(e)
	return Duel.IsExistingMatchingCard(c511009105.atfilter,e:GetHandlerPlayer(),LOCATION_MZONE,0,1,e:GetHandler())
end


function c511009105.atkcon(e,tp,eg,ep,ev,re,r,rp)
	local a=Duel.GetAttacker()
	local d=Duel.GetAttackTarget()
	if d and a:GetControler()~=d:GetControler() then
		if a:IsControler(tp) and a:IsSetCard(0xc6) then e:SetLabelObject(d)
		elseif (d:IsSetCard(0xc6)) then e:SetLabelObject(a) end
		return true
	else return false end
end
function c511009105.atktg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	local tc=e:GetLabelObject()
	if chkc then return chkc==tc end
	if chk==0 then return tc:IsOnField() and tc:IsFaceup() and tc:IsCanBeEffectTarget(e) end
	Duel.SetTargetCard(tc)
end
function c511009105.atkop(e,tp,eg,ep,ev,re,r,rp)
	local tc=Duel.GetFirstTarget()
	if tc:IsRelateToEffect(e) and tc:IsFaceup() then
		local e1=Effect.CreateEffect(e:GetHandler())
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(-600)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		tc:RegisterEffect(e1)
	end
end
