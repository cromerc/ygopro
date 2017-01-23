--サイバー・ブレイダー
function c511002991.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,97023549,11460577,false,false)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetCondition(c511002991.con)
	e1:SetValue(1)
	e1:SetLabel(1)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_SET_ATTACK_FINAL)
	e2:SetCondition(c511002991.con)
	e2:SetValue(c511002991.atkval)
	e2:SetLabel(2)
	c:RegisterEffect(e2)
	--disable
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_FIELD)
	e3:SetCode(EFFECT_DISABLE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetTargetRange(0,LOCATION_ONFIELD)
	e3:SetCondition(c511002991.con)
	e3:SetLabel(3)
	c:RegisterEffect(e3)
	--disable effect
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e4:SetCode(EVENT_CHAIN_SOLVING)
	e4:SetRange(LOCATION_MZONE)
	e4:SetLabel(3)
	e4:SetCondition(c511002991.con)
	e4:SetOperation(c511002991.disop)
	c:RegisterEffect(e4)
end
function c511002991.con(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),0,LOCATION_MZONE)==e:GetLabel()
end
function c511002991.atkval(e,c)
	return c:GetAttack()*2
end
function c511002991.disop(e,tp,eg,ep,ev,re,r,rp)
	local tl=Duel.GetChainInfo(ev,CHAININFO_TRIGGERING_LOCATION)
	if rp~=tp and (tl==LOCATION_MZONE or tl==LOCATION_SZONE) then
		Duel.NegateEffect(ev)
	end
end
