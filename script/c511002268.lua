--怨念の魂 業火
function c511002268.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCodeRep(c,23116809,3,true,true)
	--spsummon condition
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	e1:SetValue(aux.fuslimit)
	c:RegisterEffect(e1)
	--gain atk
	local e2=Effect.CreateEffect(c)
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_IGNITION)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCost(c511002268.cost)
	e2:SetOperation(c511002268.op)
	c:RegisterEffect(e2)
end
function c511002268.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(Card.IsCode,tp,LOCATION_MZONE,0,nil,23116809)
	local c=e:GetHandler()
	if chk==0 then return g:GetCount()>0 and g:FilterCount(Card.IsCanBeFusionMaterial,nil)==g:GetCount() end
	e:SetLabel(g:GetCount())
	local mg=c:GetMaterial()
	mg:Merge(g)
	c:SetMaterial(mg)
	Duel.SendtoGrave(g,REASON_COST+REASON_MATERIAL+REASON_FUSION)
end
function c511002268.op(e,tp,eg,ep,ev,re,r,rp)
	local ct=e:GetLabel()
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) then
		local e1=Effect.CreateEffect(c)
		e1:SetType(EFFECT_TYPE_SINGLE)
		e1:SetCode(EFFECT_UPDATE_ATTACK)
		e1:SetValue(e:GetLabel()*100)
		e1:SetReset(RESET_EVENT+0x1fe0000)
		c:RegisterEffect(e1)
	end
end
