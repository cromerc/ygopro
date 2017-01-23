--ホーリー・ドール a.k.a Rogue Doll (DOR)
function c511004316.initial_effect(c)
	--destroy zombie typed monster when battled with this card --> copy Vampire Hunter (80485722) eff 
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511004316,0))
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e1:SetCode(EVENT_BATTLE_START)
	e1:SetTarget(c511004316.destg)
	e1:SetOperation(c511004316.desop)
	c:RegisterEffect(e1)
end
function c511004316.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if chk==0 then return bc and bc:IsFaceup() and bc:IsRace(RACE_ZOMBIE) end
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,bc,1,0,0)
end
function c511004316.desop(e,tp,eg,ep,ev,re,r,rp)
	local c=e:GetHandler()
	local bc=c:GetBattleTarget()
	if bc:IsRelateToBattle() then
		Duel.Destroy(bc,REASON_EFFECT)
	end
end

