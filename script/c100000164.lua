--クリアー・ウォール
function c100000164.initial_effect(c)
	--activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--selfdes
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetCode(EFFECT_SELF_DESTROY)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c100000164.sdcon)
	c:RegisterEffect(e2)
	--battle indestructable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e3:SetRange(LOCATION_SZONE)
	e3:SetTargetRange(LOCATION_MZONE,0)
	e3:SetTarget(c100000164.indtg)
	e3:SetValue(1)
	c:RegisterEffect(e3)	
	local e4=Effect.CreateEffect(c)
	e4:SetDescription(aux.Stringid(100000164,0))
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCode(EVENT_DAMAGE)
	e4:SetCondition(c100000164.dscon)
	e4:SetTarget(c100000164.dstg)
	e4:SetOperation(c100000164.dsop)
	c:RegisterEffect(e4)
	--
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e5:SetRange(LOCATION_SZONE)
	e5:SetCode(EVENT_PRE_BATTLE_DAMAGE)
	e5:SetCondition(c100000164.con)
	e5:SetOperation(c100000164.activate)
	c:RegisterEffect(e5)
end
function c100000164.sdcon(e)
	return not Duel.IsEnvironment(33900648)
end
function c100000164.indtg(e,c)
	return c:IsCode(97811903) or c:IsCode(82044279) or c:IsSetCard(0x306)
end
function c100000164.dscon(e,tp,eg,ep,ev,re,r,rp)
	return bit.band(r,REASON_BATTLE)>0 and ep==tp
end
function c100000164.dstg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,e:GetHandler(),1,0,0)
end
function c100000164.dsop(e,tp,eg,ep,ev,re,r,rp)
	if e:GetHandler():IsRelateToEffect(e) then
		Duel.Destroy(e:GetHandler(),REASON_EFFECT)
	end
end
function c100000164.con(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetBattleDamage(tp)<=1000
end
function c100000164.activate(e,tp,eg,ep,ev,re,r,rp)
	Duel.ChangeBattleDamage(tp,0)
end