--Action Card - Illusion Dance
function c95000130.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetCategory(CATEGORY_POSITION)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetTarget(c95000130.target)
	e1:SetOperation(c95000130.activate)
	c:RegisterEffect(e1)
	--act in hand
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_QP_ACT_IN_NTPHAND)
	e2:SetCondition(c95000130.handcon)
	c:RegisterEffect(e2)
end
function c95000130.handcon(e)
	return tp~=Duel.GetTurnPlayer()
end

function c95000130.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(Card.IsAttackPos,tp,LOCATION_MZONE,LOCATION_MZONE,1,nil) end
	local g=Duel.GetMatchingGroup(Card.IsAttackPos,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_POSITION,g,g:GetCount(),0,0)
end
function c95000130.activate(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local g=Duel.GetMatchingGroup(c95000130.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	if g:GetCount()>0 then
		Duel.ChangePosition(g,POS_FACEUP_DEFENSE)
		local tc=g:GetFirst()
		while tc do
			local e1=Effect.CreateEffect(c)
			e1:SetDescription(aux.Stringid(79491903,1))
			e1:SetCategory(CATEGORY_POSITION)
			e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
			e1:SetCode(EVENT_PHASE+PHASE_END)
			e1:SetRange(LOCATION_MZONE)
			e1:SetReset(RESET_EVENT+0x1fe0000+RESET_PHASE+PHASE_END)
			e1:SetCountLimit(1)
			e1:SetTarget(c95000130.postg2)
			e1:SetOperation(c95000130.posop2)
			tc:RegisterEffect(e1)
			tc=g:GetNext()
		end
	end
end

function c95000130.postg2(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return e:GetHandler():IsDefensePos() end
	Duel.SetOperationInfo(0,CATEGORY_POSITION,e:GetHandler(),1,0,0)
end
function c95000130.posop2(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	if c:IsFaceup() and c:IsRelateToEffect(e) and c:IsDefensePos() then
		Duel.ChangePosition(c,0,0,POS_FACEUP_ATTACK,0)
	end
end