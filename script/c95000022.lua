--Number C1: Numeron Chaos Gate Shunya
function c95000022.initial_effect(c)
    --no type/attribute/level
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CHANGE_RACE)
	e1:SetValue(0)
	c:RegisterEffect(e1)
	local e2=Effect.CreateEffect(c)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetCode(EFFECT_CHANGE_ATTRIBUTE)
	c:RegisterEffect(e2)
	c:SetStatus(STATUS_NO_LEVEL,true)
	--cannot special summon
	local e3=Effect.CreateEffect(c)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e3)
	--summon with 1 tribute
	local e4=Effect.CreateEffect(c)
	e4:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_LIMIT_SUMMON_PROC)
	e4:SetCondition(c95000022.ttcon)
	e4:SetOperation(c95000022.ttop)
	e4:SetValue(SUMMON_TYPE_ADVANCE)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EFFECT_LIMIT_SET_PROC)
	c:RegisterEffect(e5)
	--tribute limit
	local e6=Effect.CreateEffect(c)
	e6:SetType(EFFECT_TYPE_SINGLE)
	e6:SetCode(EFFECT_TRIBUTE_LIMIT)
	e6:SetValue(c95000022.tlimit)
	c:RegisterEffect(e6)
	--spsummon
	local e7=Effect.CreateEffect(c)
	e7:SetDescription(aux.Stringid(95000022,0))
	e7:SetCategory(CATEGORY_DAMAGE)
	e7:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e7:SetCountLimit(1)
	e7:SetType(EFFECT_TYPE_IGNITION)
	e7:SetRange(LOCATION_MZONE)
	e7:SetCost(c95000022.damcost)
	e7:SetTarget(c95000022.damtg)
	e7:SetOperation(c95000022.damop)
	c:RegisterEffect(e7)
end
c95000022.mark=0
function c95000022.ttcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>-1 and Duel.GetTributeCount(c)>=1
end
function c95000022.ttop(e,tp,eg,ep,ev,re,r,rp,c)
	local g=Duel.SelectTribute(tp,c,1,1)
	c:SetMaterial(g)
	Duel.Release(g,REASON_SUMMON+REASON_MATERIAL)
end
function c95000022.tlimit(e,c)
	return not c:IsType(TYPE_TOKEN) or not c:IsSetCard(0x48)
end
function c95000022.damcost(e,tp,eg,ep,ev,re,r,rp,chk)
	local g=Duel.GetMatchingGroup(nil,tp,LOCATION_MZONE,0,e:GetHandler())
	if chk==0 then return g:GetCount()>0 and g:FilterCount(Card.IsReleasable,nil)==g:GetCount() end
	local atk=g:GetSum(Card.GetAttack)
	Duel.Release(g,REASON_COST)
	e:SetLabel(atk)
end
function c95000022.damtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetTargetPlayer(1-tp)
	Duel.SetTargetParam(e:GetLabel())
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,e:GetLabel())
end
function c95000022.damop(e,tp,eg,ep,ev,re,r,rp)
	local p,d=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER,CHAININFO_TARGET_PARAM)
	Duel.Damage(p,d,REASON_EFFECT)
end
