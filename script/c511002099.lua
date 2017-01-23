--Agent of Hatred
function c511002099.initial_effect(c)
	--gain lp
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(511002099,0))
	e1:SetCategory(CATEGORY_RECOVER)
	e1:SetProperty(EFFECT_FLAG_PLAYER_TARGET)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e1:SetCode(EVENT_PHASE+PHASE_BATTLE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetCondition(c511002099.reccon)
	e1:SetTarget(c511002099.rectg)
	e1:SetOperation(c511002099.recop)
	c:RegisterEffect(e1)
	if not c511002099.global_check then
		c511002099.global_check=true
		c511002099[0]=0
		--register
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_BATTLE_DAMAGE)
		ge1:SetOperation(c511002099.regop)
		Duel.RegisterEffect(ge1,0)
		local ge2=Effect.CreateEffect(c)
		ge2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge2:SetCode(EVENT_ADJUST)
		ge2:SetCountLimit(1)
		ge2:SetOperation(c511002099.clear)
		Duel.RegisterEffect(ge2,0)
	end
end
function c511002099.reccon(e,tp,eg,ep,ev,re,r,rp)
	return Duel.GetTurnPlayer()~=tp
end
function c511002099.rectg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return c511002099[0]>0 end
	Duel.SetTargetPlayer(tp)
	Duel.SetOperationInfo(0,CATEGORY_RECOVER,nil,0,tp,0)
end
function c511002099.recop(e,tp,eg,ep,ev,re,r,rp)
	local p=Duel.GetChainInfo(0,CHAININFO_TARGET_PLAYER)
	local i=1
	local ct=c511002099[0]
	local rg=Group.CreateGroup()
	local dam=0
	while i<ct do
		rg:AddCard(c511002099[i])
		i=i+2
	end
	local sc=rg:Select(tp,1,1,nil):GetFirst()
	local multiatk=false
	i=1
	while i<ct and sc~=c511002099[i] do
		i=i+2
	end
	dam=c511002099[i+1]
	t=i+2
	while i<ct do
		if sc==c511002099[i] then
			multiatk=true
		end
		i=i+2
	end
	if multiatk then
		i=1
		local t={}
		local p=1
		while i<ct do
			if sc==c511002099[i] then
				t[p]=c511002099[i+1]
				p=p+1
			end
			i=i+2
		end
		t[p]=nil
		dam=Duel.AnnounceNumber(tp,table.unpack(t))
	end
	Duel.Recover(p,dam,REASON_EFFECT)
end
function c511002099.regop(e,tp,eg,ep,ev,re,r,rp)
	if ep==1-Duel.GetTurnPlayer() then
		local ct=c511002099[0]
		c511002099[ct+1]=eg:GetFirst()
		c511002099[ct+2]=ev
		c511002099[0]=ct+2
	end
end
function c511002099.clear(e,tp,eg,ep,ev,re,r,rp)
	local ct=c511002099[0]
	if ct>0 then
		local i=1
		while c511002099[i]~=nil do
			c511002099[i]=nil
			i=i+1
		end
		c511002099[0]=0
	end
end
