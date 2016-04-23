--冥界龍ドラゴネクロ
function c100002003.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcFunRep(c,aux.FilterBoolFunction(Card.IsRace,RACE_ZOMBIE),2,false)

	--battle
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCode(EVENT_DAMAGE_CALCULATING)
	e1:SetCondition(c100002003.indescon)
	e1:SetOperation(c100002003.indesop)
	c:RegisterEffect(e1)

	--atk change
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(100002003,0))
	e2:SetCategory(CATEGORY_ATKCHANGE)
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_BATTLE_END)
	e2:SetTarget(c100002003.atktg)
	e2:SetOperation(c100002003.operation)
	c:RegisterEffect(e2)

	--token
	local e3=Effect.CreateEffect(c)
	e3:SetDescription(aux.Stringid(100002003,0))
	e3:SetCategory(CATEGORY_SPECIAL_SUMMON+CATEGORY_TOKEN)
	e3:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e3:SetCode(EVENT_BATTLED)
	e3:SetCondition(c100002003.condi)
	e3:SetTarget(c100002003.target)
	e3:SetOperation(c100002003.op)
	c:RegisterEffect(e3)

end
function c100002003.indescon(e,tp,eg,ep,ev,re,r,rp)
	return e:GetHandler():GetBattleTarget()~=nil
end
function c100002003.indesop(e,tp,eg,ep,ev,re,r,rp)
	local bc=e:GetHandler():GetBattleTarget()
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_INDESTRUCTABLE_BATTLE)
	e1:SetValue(1)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	bc:RegisterEffect(e1,true)
end

function c100002003.filter(c,bc)
	return c:GetBattledGroup():IsContains(bc)
end
function c100002003.atktg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100002003.filter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler()) end
end

function c100002003.operation(e,tp,eg,ep,ev,re,r,rp)
	local d=e:GetHandler():GetBattleTarget()
	if not d:IsRelateToBattle() then return end
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SET_ATTACK_FINAL)
	e1:SetValue(0)
	e1:SetReset(RESET_EVENT+0x1fe0000)
	d:RegisterEffect(e1)
	local e2=Effect.CreateEffect(e:GetHandler())
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_CHANGE_POSITION)
	e2:SetReset(RESET_EVENT+0x1fe0000)
	d:RegisterEffect(e2)

	Duel.ChangePosition(d,POS_FACEUP_ATTACK)
end

function c100002003.condi(e,tp,eg,ep,ev,re,r,rp)
	return not e:GetHandler():IsReason(REASON_RETURN)
end
function c100002003.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c100002003.filter,tp,0,LOCATION_MZONE,1,nil,e:GetHandler()) end
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_TOKEN,nil,1,0,0)
	Duel.SetOperationInfo(0,CATEGORY_SPECIAL_SUMMON,nil,1,0,0)	
end
function c100002003.op(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetLocationCount(tp,LOCATION_MZONE)<1 then return end
	local tc=e:GetHandler():GetBattleTarget()
	if not Duel.IsPlayerCanSpecialSummonMonster(tp,100002004,0,0x4011,0,0,1,RACE_ZOMBIE,ATTRIBUTE_DARK) then return end
	local token=Duel.CreateToken(tp,100002004)
	Duel.SpecialSummonStep(token,0,tp,tp,false,false,POS_FACEUP)	
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetValue(tc:GetBaseAttack())
	token:RegisterEffect(e1)

end