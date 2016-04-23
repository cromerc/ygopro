--ＣＮｏ．１５ ギミック・パペット－シリアルキラー
function c100000575.initial_effect(c)
	--xyz summon
	aux.AddXyzProcedure(c,aux.XyzFilterFunction(c,9),3)
	c:EnableReviveLimit()
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_SPSUMMON_SUCCESS)
	e1:SetCondition(c100000575.recon)
	e1:SetOperation(c100000575.reop)
	c:RegisterEffect(e1)
	--battle indestructable
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e2:SetValue(c100000575.indes)
	c:RegisterEffect(e2)
end
c100000575.xyz_number=15
function c100000575.indes(e,c)
	return not c:IsSetCard(0x48)
end
function c100000575.recon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetSummonType()==SUMMON_TYPE_XYZ
	 and e:GetHandler():GetOverlayGroup():IsExists(Card.IsCode,1,nil,88120966)
end
function c100000575.reop(e,tp,eg,ep,ev,re,r,rp)	
	--Disable
	local e3=Effect.CreateEffect(e:GetHandler())
	e3:SetCategory(CATEGORY_DESTROY+CATEGORY_DAMAGE)
	e3:SetType(EFFECT_TYPE_IGNITION)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCost(c100000575.cost)
	e3:SetTarget(c100000575.distg)
	e3:SetOperation(c100000575.disop)
	e3:SetReset(RESET_EVENT+0x1fe0000)
	e:GetHandler():RegisterEffect(e3)
end
function c100000575.cost(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():CheckRemoveOverlayCard(tp,1,REASON_COST) end
	e:GetHandler():RemoveOverlayCard(tp,1,1,REASON_COST)
end
function c100000575.distg(e,tp,eg,ep,ev,re,r,rp,chk,chkc)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsDestructable,tp,0,LOCATION_MZONE,1,nil) end
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,sg,sg:GetCount(),0,0)
	Duel.SetOperationInfo(0,CATEGORY_DAMAGE,nil,0,1-tp,nil)
end
function c100000575.disop(e,tp,eg,ep,ev,re,r,rp)
	local sg=Duel.GetMatchingGroup(Card.IsDestructable,tp,0,LOCATION_MZONE,nil)
	local tc=sg:GetFirst()
	local atk=0
	local dam=0
	while tc do
		atk=tc:GetAttack()
		if tc:IsFaceup() and atk>0 then dam=dam+atk end
		tc=sg:GetNext()
	end
	if Duel.Destroy(sg,REASON_EFFECT)~=0 then
		Duel.Damage(1-tp,dam,REASON_EFFECT)
	end
end