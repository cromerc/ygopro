--Reverse Wall
--	by Snrk
local self=c511008029

function self.initial_effect(c)
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_DESTROYED)
	e1:SetProperty(EFFECT_FLAG_DAMAGE_STEP)
	e1:SetCondition(self.cd)
	e1:SetTarget(self.tg)
	e1:SetOperation(self.op)
	c:RegisterEffect(e1)
end

function self.desg(p) return Duel.GetMatchingGroup(Card.IsDestructable,p,0,LOCATION_MZONE,nil) end
function self.exist(p) return Duel.IsExistingMatchingCard(Card.IsDestructable,p,0,LOCATION_MZONE,1,nil) end
function self.cf(c,p) return c:GetPreviousControler()==p and c:IsPreviousLocation(LOCATION_MZONE) and c:IsType(TYPE_MONSTER) and c:GetPreviousDefenseOnField()>=2000 end

function self.cd(e,tp,eg) return eg:IsExists(self.cf,1,nil,tp) end
function self.tg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return self.exist(tp) end
	local g=self.desg(tp)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function self.op(e,tp)
	if not self.exist(tp) then return end
	Duel.Destroy(self.desg(tp),REASON_EFFECT)
end








